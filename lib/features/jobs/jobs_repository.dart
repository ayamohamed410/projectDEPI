import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'job_model.dart';
import 'parse_utils.dart';

/// The single place that talks to `jobs` in Firestore.
///
/// Customer side (booking, chat, rating):
///   final repo = JobsRepository();
///   final jobId = await repo.createBooking(technicianId: id, diagnosisTitle: 'Leaking tap');
///   repo.watchMessages(jobId) / repo.sendMessage(jobId, 'Hello')
///   await repo.submitRating(jobId, 5, 'Great work');
///
/// Technician side (requests, active job, history):
///   repo.watchTechnicianJobs()          // everything for the signed-in technician
///   await repo.acceptJob(jobId);
///   await repo.updateStatus(jobId, JobStatus.onWay);
///   await repo.completeJob(jobId);
///
/// All queries filter by ONE field only, so no composite index is needed.
class JobsRepository {
  JobsRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _db = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _db;
  final FirebaseAuth _auth;

  CollectionReference<Map<String, dynamic>> get _jobs => _db.collection('jobs');
  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');
  CollectionReference<Map<String, dynamic>> _messages(String jobId) =>
      _jobs.doc(jobId).collection('messages');

  /// The signed-in user's uid. Throws if nobody is signed in.
  String get currentUid {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('No signed-in user');
    return uid;
  }

  // ---------------------------------------------------------------- reads

  /// Technicians for the customer's list (users where role == technician).
  /// Each map has the user's fields plus an 'id' key.
  Stream<List<Map<String, dynamic>>> watchTechnicians() => _users
      .where('role', isEqualTo: 'technician')
      .snapshots()
      .map((s) => s.docs.map((d) => {...d.data(), 'id': d.id}).toList());

  Stream<JobModel?> watchJob(String jobId) => _jobs.doc(jobId).snapshots().map(
        (s) {
          final data = s.data();
          return data == null ? null : JobModel.fromMap(s.id, data);
        },
      );

  /// All jobs of a technician (default: the signed-in one), newest first.
  /// Filter by status / month on the device.
  Stream<List<JobModel>> watchTechnicianJobs([String? technicianId]) => _jobs
      .where('technicianId', isEqualTo: technicianId ?? currentUid)
      .snapshots()
      .map(_toJobs);

  Future<List<JobModel>> getTechnicianJobs([String? technicianId]) async {
    final snap = await _jobs
        .where('technicianId', isEqualTo: technicianId ?? currentUid)
        .get();
    return _toJobs(snap);
  }

  /// All jobs of a customer (default: the signed-in one), newest first.
  Stream<List<JobModel>> watchCustomerJobs([String? customerId]) => _jobs
      .where('customerId', isEqualTo: customerId ?? currentUid)
      .snapshots()
      .map(_toJobs);

  /// The job the technician is working on right now, or null. Lets the
  /// Active Job / Chat screens find their job when nobody passes a jobId.
  Future<JobModel?> getActiveJobForTechnician([String? technicianId]) async {
    final jobs = await getTechnicianJobs(technicianId);
    for (final j in jobs) {
      if (j.isActive) return j;
    }
    return null;
  }

  List<JobModel> _toJobs(QuerySnapshot<Map<String, dynamic>> snap) {
    final jobs = snap.docs.map((d) => JobModel.fromMap(d.id, d.data())).toList();
    jobs.sort((a, b) {
      final da = a.createdAt ?? DateTime.now();
      final db = b.createdAt ?? DateTime.now();
      return db.compareTo(da);
    });
    return jobs;
  }

  // ------------------------------------------------------------ customer

  /// Called by the customer's "Book" button. Returns the new job id.
  Future<String> createBooking({
    required String technicianId,
    required String diagnosisTitle,
    String problemDescription = '',
    String customerArea = '',
    double baseAmount = 0,
  }) async {
    final uid = currentUid;
    final userSnap = await _users.doc(uid).get();
    final ref = _jobs.doc();
    await ref.set({
      'customerId': uid,
      'technicianId': technicianId,
      'customerName': asString(userSnap.data()?['name']),
      'customerPhone': asString(userSnap.data()?['phone']),
      'customerArea': customerArea,
      'requestNumber': _newRequestNumber(),
      'diagnosisTitle': diagnosisTitle,
      'problemDescription': problemDescription,
      'status': JobStatus.pending,
      'statusHistory': [
        {'status': JobStatus.pending, 'at': Timestamp.now()},
      ],
      'parts': <Map<String, dynamic>>[],
      'baseAmount': baseAmount,
      'partsAmount': 0,
      'totalAmount': baseAmount,
      'netPayout': 0,
      'customerSigned': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return ref.id;
  }

  String _newRequestNumber() {
    final n = DateTime.now().millisecondsSinceEpoch % 10000;
    return '#7H-${n.toString().padLeft(4, '0')}';
  }

  /// The customer signs off the finished work ("Completed & Signed").
  Future<void> confirmCompletion(String jobId) =>
      _jobs.doc(jobId).update({'customerSigned': true});

  /// Customer cancels (or technician declines). [cancellationFee] is the
  /// amount credited to the technician ("Fee Credited" on Jobs History).
  Future<void> cancelJob(
    String jobId, {
    String cancelledBy = 'customer',
    double cancellationFee = 0,
  }) =>
      _jobs.doc(jobId).update({
        'status': JobStatus.cancelled,
        'cancelledBy': cancelledBy,
        'cancellationFee': cancellationFee,
        'closedAt': FieldValue.serverTimestamp(),
        'statusHistory': FieldValue.arrayUnion([
          {'status': JobStatus.cancelled, 'at': Timestamp.now()},
        ]),
      });

  /// Stores the rating on the job and updates the technician's average.
  /// The average update is best-effort: if Firestore rules forbid a customer
  /// writing another user's document it is skipped (the job still gets rated).
  Future<void> submitRating(
    String jobId,
    double rating, [
    String? reviewText,
  ]) async {
    final jobRef = _jobs.doc(jobId);
    final data = (await jobRef.get()).data();
    if (data == null) throw StateError('Job not found');
    final oldRating = asDouble(data['rating']);
    final techId = asString(data['technicianId']);

    await jobRef.update({
      'rating': rating,
      'reviewText': (reviewText ?? '').trim(),
    });

    if (techId.isEmpty) return;
    try {
      await _db.runTransaction<void>((tx) async {
        final techRef = _users.doc(techId);
        final tech = (await tx.get(techRef)).data() ?? <String, dynamic>{};
        final count = (asDouble(tech['reviewsCount']) ?? 0).toInt();
        final avg = asDouble(tech['ratingAvg']) ?? 0;

        int newCount;
        double newAvg;
        if (oldRating == null) {
          newCount = count + 1;
          newAvg = (avg * count + rating) / newCount;
        } else if (count < 1) {
          newCount = 1;
          newAvg = rating;
        } else {
          newCount = count;
          newAvg = (avg * count - oldRating + rating) / count;
        }
        tx.set(
          techRef,
          {
            'ratingAvg': double.parse(newAvg.toStringAsFixed(2)),
            'reviewsCount': newCount,
          },
          SetOptions(merge: true),
        );
      });
    } on FirebaseException {
      // Rules may block this write; the job rating above is already saved.
    }
  }

  // ----------------------------------------------------------- technician

  Future<void> acceptJob(String jobId) => updateStatus(jobId, JobStatus.accepted);

  /// Moves the job to [status] and records it in `statusHistory`.
  /// Use [completeJob] for the final step so totals and counters update.
  Future<void> updateStatus(String jobId, String status) =>
      _jobs.doc(jobId).update({
        'status': status,
        'statusHistory': FieldValue.arrayUnion([
          {'status': status, 'at': Timestamp.now()},
        ]),
        if (status == JobStatus.cancelled) 'closedAt': FieldValue.serverTimestamp(),
      });

  /// Adds a part and recomputes partsAmount / totalAmount.
  Future<void> addPart(String jobId, JobPart part) =>
      _db.runTransaction<void>((tx) async {
        final ref = _jobs.doc(jobId);
        final data = (await tx.get(ref)).data();
        if (data == null) throw StateError('Job not found');

        final parts = ((data['parts'] as List?) ?? const [])
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList()
          ..add(part.toMap());
        final partsAmount =
            parts.fold<double>(0, (s, p) => s + (asDouble(p['price']) ?? 0));
        final base = asDouble(data['baseAmount']) ?? 0;

        tx.update(ref, {
          'parts': parts,
          'partsAmount': partsAmount,
          'totalAmount': base + partsAmount,
        });
      });

  /// Sets "Base Inspection & Labor" and recomputes totalAmount.
  Future<void> setBaseAmount(String jobId, double amount) =>
      _db.runTransaction<void>((tx) async {
        final ref = _jobs.doc(jobId);
        final data = (await tx.get(ref)).data();
        if (data == null) throw StateError('Job not found');
        final partsAmount = asDouble(data['partsAmount']) ?? 0;
        tx.update(ref, {
          'baseAmount': amount,
          'totalAmount': amount + partsAmount,
        });
      });

  /// [before] true = "Before Fix" photo, false = "After Fix" photo.
  Future<void> setPhotoUrl(String jobId, {required bool before, required String url}) =>
      _jobs.doc(jobId).update({before ? 'beforePhotoUrl' : 'afterPhotoUrl': url});

  /// Final step: status = completed, netPayout = totalAmount - [platformFee],
  /// and the technician's completedJobsCount goes up by one.
  Future<void> completeJob(String jobId, {double platformFee = 0}) =>
      _db.runTransaction<void>((tx) async {
        final ref = _jobs.doc(jobId);
        final data = (await tx.get(ref)).data();
        if (data == null) throw StateError('Job not found');

        final total = asDouble(data['totalAmount']) ??
            ((asDouble(data['baseAmount']) ?? 0) +
                (asDouble(data['partsAmount']) ?? 0));
        final techId = asString(data['technicianId']);

        tx.update(ref, {
          'status': JobStatus.completed,
          'netPayout': total - platformFee,
          'closedAt': FieldValue.serverTimestamp(),
          'statusHistory': FieldValue.arrayUnion([
            {'status': JobStatus.completed, 'at': Timestamp.now()},
          ]),
        });
        if (techId.isNotEmpty) {
          tx.set(
            _users.doc(techId),
            {'completedJobsCount': FieldValue.increment(1)},
            SetOptions(merge: true),
          );
        }
      });
/// Technician reports a problem / delay on the job (Active Job screen).
  Future<void> reportIssue(String jobId, String reason) =>
      _jobs.doc(jobId).update({
        'issueReason': reason,
        'issueReportedAt': FieldValue.serverTimestamp(),
      });

  // ---------------------------------------------------------------- chat

  Stream<List<ChatMessage>> watchMessages(String jobId) => _messages(jobId)
      .orderBy('createdAt')
      .snapshots()
      .map((s) => s.docs.map((d) => ChatMessage.fromMap(d.id, d.data())).toList());

  Future<void> sendMessage(String jobId, String text, {String? imageUrl}) async {
    final t = text.trim();
    if (t.isEmpty && (imageUrl == null || imageUrl.isEmpty)) return;
    await _messages(jobId).add({
      'senderId': currentUid,
      'text': t,
      'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'readAt': null,
    });
  }

  /// Marks the other person's unread messages as read (the double tick).
  Future<void> markMessagesRead(String jobId) async {
    final uid = currentUid;
    final snap = await _messages(jobId).where('readAt', isNull: true).get();
    final batch = _db.batch();
    var changed = 0;
    for (final d in snap.docs) {
      if (d.data()['senderId'] != uid) {
        batch.update(d.reference, {'readAt': FieldValue.serverTimestamp()});
        changed++;
      }
    }
    if (changed > 0) await batch.commit();
  }

  /// Unread messages sent by the other person (badge on the Chat button).
  Stream<int> watchUnreadCount(String jobId) {
    final uid = currentUid;
    return watchMessages(jobId).map(
      (list) => list.where((m) => m.senderId != uid && m.readAt == null).length,
    );
  }
}
