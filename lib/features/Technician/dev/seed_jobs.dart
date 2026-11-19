import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SeedJobs {
  static Future<void> seed() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final db = FirebaseFirestore.instance;
    final now = DateTime.now();
    final prevMonth = DateTime(now.year, now.month - 1, 15);

    final batch = db.batch();

    // 1. Completed + Signed with review
    final ref1 = db.collection('jobs').doc();
    batch.set(ref1, {
      'technicianId': uid,
      'customerId': uid,
      'customerName': 'Tarek Mansour',
      'customerArea': 'New Cairo, Fifth Settlement',
      'requestNumber': '#7H-9482',
      'diagnosisTitle': 'Kitchen Sink High Pressure Pipe Leak',
      'status': 'completed',
      'customerSigned': true,
      'rating': 5.0,
      'reviewText': 'Exceptional Service!',
      'netPayout': 370.0,
      'createdAt': Timestamp.fromDate(now.subtract(const Duration(hours: 2))),
      'closedAt': Timestamp.fromDate(now),
    });

    // 2. Completed unsigned with rating only
    final ref2 = db.collection('jobs').doc();
    batch.set(ref2, {
      'technicianId': uid,
      'customerId': uid,
      'customerName': 'Karim H.',
      'customerArea': 'Maadi Degla',
      'requestNumber': '#7H-9441',
      'diagnosisTitle': 'Main Water Shutoff Valve Overhaul',
      'status': 'completed',
      'customerSigned': false,
      'rating': 4.8,
      'reviewText': '',
      'netPayout': 520.0,
      'createdAt': Timestamp.fromDate(now.subtract(const Duration(days: 1))),
      'closedAt': Timestamp.fromDate(now.subtract(const Duration(days: 1))),
    });

    // 3. Cancelled with cancellationFee 75
    final ref3 = db.collection('jobs').doc();
    batch.set(ref3, {
      'technicianId': uid,
      'customerId': uid,
      'customerName': 'Outdoor Client',
      'customerArea': 'Zamalek',
      'requestNumber': '#7H-9380',
      'diagnosisTitle': 'Outdoor Line Inspection',
      'status': 'cancelled',
      'cancelledBy': 'customer',
      'cancellationFee': 75.0,
      'netPayout': 0.0,
      'createdAt': Timestamp.fromDate(now.subtract(const Duration(days: 3))),
      'closedAt': Timestamp.fromDate(now.subtract(const Duration(days: 3))),
    });

    // 4. Disputed
    final ref4 = db.collection('jobs').doc();
    batch.set(ref4, {
      'technicianId': uid,
      'customerId': uid,
      'customerName': 'Nourhan El-Sayed',
      'customerArea': 'Sheikh Zayed, District 9',
      'requestNumber': '#7H-9310',
      'diagnosisTitle': 'Central Water Heater Element Replacement',
      'status': 'disputed',
      'customerSigned': false,
      'rating': 4.9,
      'reviewText': 'Verified',
      'netPayout': 680.0,
      'createdAt': Timestamp.fromDate(now.subtract(const Duration(days: 5))),
      'closedAt': Timestamp.fromDate(now.subtract(const Duration(days: 5))),
    });

    // 5 & 6. Two completed jobs in the previous month
    final ref5 = db.collection('jobs').doc();
    batch.set(ref5, {
      'technicianId': uid,
      'customerId': uid,
      'customerName': 'Mona Zaki',
      'customerArea': 'Heliopolis',
      'requestNumber': '#7H-8811',
      'diagnosisTitle': 'Bathroom Mixer Installation',
      'status': 'completed',
      'customerSigned': true,
      'rating': 5.0,
      'netPayout': 1200.0,
      'createdAt': Timestamp.fromDate(prevMonth),
      'closedAt': Timestamp.fromDate(prevMonth),
    });

    final ref6 = db.collection('jobs').doc();
    batch.set(ref6, {
      'technicianId': uid,
      'customerId': uid,
      'customerName': 'Ahmed Helmy',
      'customerArea': 'Nasr City',
      'requestNumber': '#7H-8822',
      'diagnosisTitle': 'Drain Unblocking',
      'status': 'completed',
      'customerSigned': true,
      'rating': 4.7,
      'netPayout': 950.0,
      'createdAt': Timestamp.fromDate(prevMonth),
      'closedAt': Timestamp.fromDate(prevMonth),
    });

    await batch.commit();
  }
}