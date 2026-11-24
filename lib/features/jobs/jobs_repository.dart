import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'job_model.dart';
import 'parse_utils.dart';

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

  String get currentUid {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('No signed-in user');
    return uid;
  }

  Stream<List<Map<String, dynamic>>> watchTechnicians() => _users
      .where('role', isEqualTo: 'technician')
      .snapshots()
      .map((s) => s.docs.map((d) => {...d.data(), 'id': d.id}).toList());

  Stream<JobModel?> watchJob(String jobId) =>
      _jobs.doc(jobId).snapshots().map((s) {
        final data = s.data();
        return data == null ? null : JobModel.fromMap(s.id, data);
      });

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

  Stream<List<JobModel>> watchCustomerJobs([String? customerId]) => _jobs
      .where('customerId', isEqualTo: customerId ?? currentUid)
      .snapshots()
      .map(_toJobs);

  Future<JobModel?> getActiveJobForTechnician([String? technicianId]) async {
    final jobs = await getTechnicianJobs(technicianId);
    for (final j in jobs) {
      if (j.isActive) return j;
    }
    return null;
  }

  List<JobModel> _toJobs(QuerySnapshot<Map<String, dynamic>> snap) {
    final jobs = snap.docs
        .map((d) => JobModel.fromMap(d.id, d.data()))
        .toList();
    jobs.sort((a, b) {
      final da = a.createdAt ?? DateTime.now();
      final db = b.createdAt ?? DateTime.now();
      return db.compareTo(da);
    });
    return jobs;
  }

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

  Future<void> confirmCompletion(String jobId) =>
      _jobs.doc(jobId).update({'customerSigned': true});

  /// Customer cancels (or technician declines). [cancellationFee] is the

  Future<void> cancelJob(
    String jobId, {
    String cancelledBy = 'customer',
    double cancellationFee = 0,
  }) => _jobs.doc(jobId).update({
    'status': JobStatus.cancelled,
    'cancelledBy': cancelledBy,
    'cancellationFee': cancellationFee,
    'closedAt': FieldValue.serverTimestamp(),
    'statusHistory': FieldValue.arrayUnion([
      {'status': JobStatus.cancelled, 'at': Timestamp.now()},
    ]),
  });

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
        tx.set(techRef, {
          'ratingAvg': double.parse(newAvg.toStringAsFixed(2)),
          'reviewsCount': newCount,
        }, SetOptions(merge: true));
      });
    } on FirebaseException {}
  }

  Future<void> acceptJob(String jobId) =>
      updateStatus(jobId, JobStatus.accepted);

  /// Moves the job to [status] and records it in `statusHistory`.

  Future<void> updateStatus(String jobId, String status) =>
      _jobs.doc(jobId).update({
        'status': status,
        'statusHistory': FieldValue.arrayUnion([
          {'status': status, 'at': Timestamp.now()},
        ]),
        if (status == JobStatus.cancelled)
          'closedAt': FieldValue.serverTimestamp(),
      });

  Future<void> addPart(String jobId, JobPart part) =>
      _db.runTransaction<void>((tx) async {
        final ref = _jobs.doc(jobId);
        final data = (await tx.get(ref)).data();
        if (data == null) throw StateError('Job not found');

        final parts =
            ((data['parts'] as List?) ?? const [])
                .whereType<Map>()
                .map((e) => Map<String, dynamic>.from(e))
                .toList()
              ..add(part.toMap());
        final partsAmount = parts.fold<double>(
          0,
          (s, p) => s + (asDouble(p['price']) ?? 0),
        );
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
  Future<void> setPhotoUrl(
    String jobId, {
    required bool before,
    required String url,
  }) => _jobs.doc(jobId).update({
    before ? 'beforePhotoUrl' : 'afterPhotoUrl': url,
  });

  /// Final step: status = completed, netPayout = totalAmount - [platformFee],

  Future<void> completeJob(String jobId, {double platformFee = 0}) =>
      _db.runTransaction<void>((tx) async {
        final ref = _jobs.doc(jobId);
        final data = (await tx.get(ref)).data();
        if (data == null) throw StateError('Job not found');

        final total =
            asDouble(data['totalAmount']) ??
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
          tx.set(_users.doc(techId), {
            'completedJobsCount': FieldValue.increment(1),
          }, SetOptions(merge: true));
        }
      });

  Future<void> reportIssue(String jobId, String reason) =>
      _jobs.doc(jobId).update({
        'issueReason': reason,
        'issueReportedAt': FieldValue.serverTimestamp(),
      });

  Stream<List<ChatMessage>> watchMessages(String jobId) => _messages(jobId)
      .orderBy('createdAt')
      .snapshots()
      .map(
        (s) => s.docs.map((d) => ChatMessage.fromMap(d.id, d.data())).toList(),
      );

  Future<void> sendMessage(
    String jobId,
    String text, {
    String? imageUrl,
  }) async {
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

  Stream<int> watchUnreadCount(String jobId) {
    final uid = currentUid;
    return watchMessages(jobId).map(
      (list) => list.where((m) => m.senderId != uid && m.readAt == null).length,
    );
  }

  Future<void> deleteCustomerRequest(String jobId) async {
    final jobRef = _jobs.doc(jobId);

    // Check if the request exists.
    final jobSnapshot = await jobRef.get();

    if (!jobSnapshot.exists) {
      throw StateError('Request not found.');
    }

    // Check request ownership.
    final jobData = jobSnapshot.data();

    if (jobData == null || jobData['customerId'] != currentUid) {
      throw StateError('You are not allowed to delete this request.');
    }

    // Check if cancellation is still allowed.
    final status = jobData['status'];

    const cancellableStatuses = [
      JobStatus.pending,
      JobStatus.accepted,
      JobStatus.onWay,
    ];

    if (!cancellableStatuses.contains(status)) {
      throw StateError(
        'The technician has arrived. You can no longer cancel this request.',
      );
    }

    // Delete chat messages first.
    final messagesSnapshot = await _messages(jobId).get();

    const batchSize = 450;

    for (var i = 0; i < messagesSnapshot.docs.length; i += batchSize) {
      final batch = _db.batch();

      final end = (i + batchSize < messagesSnapshot.docs.length)
          ? i + batchSize
          : messagesSnapshot.docs.length;

      for (final message in messagesSnapshot.docs.sublist(i, end)) {
        batch.delete(message.reference);
      }

      await batch.commit();
    }

    // Delete the request.
    await jobRef.delete();
  }
}
