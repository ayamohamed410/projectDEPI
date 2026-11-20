import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SeedChat {
  static Future<void> seed() async {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? 'test_tech_uid';
    final firestore = FirebaseFirestore.instance;
    final jobId = 'job_chat_test_123';


    await firestore.collection('jobs').doc(jobId).set({
      'id': jobId,
      'technicianId': uid,
      'customerId': uid,
      'customerName': 'Tarek Mansour',
      'customerArea': 'New Cairo, District 5',
      'requestNumber': '#7H-9482',
      'status': 'in_progress',
      'diagnosisTitle': 'Kitchen Sink High Pressure Pipe Leak',
      'customerSigned': false,
      'createdAt': FieldValue.serverTimestamp(),
      'statusHistory': ['accepted', 'on_way', 'arrived', 'in_progress'],
    }, SetOptions(merge: true));

  
    final messagesRef = firestore.collection('jobs').doc(jobId).collection('messages');
    
  
    final snapshots = await messagesRef.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }

    final now = DateTime.now();

    await messagesRef.add({
      'senderId': uid,
      'text': 'Hello Mr. Tarek, I have accepted your request and I am en route with the replacement compression valves.',
      'createdAt': Timestamp.fromDate(now.subtract(const Duration(minutes: 15))),
      'readAt': Timestamp.fromDate(now.subtract(const Duration(minutes: 14))),
    });

    await messagesRef.add({
      'senderId': 'seed_customer',
      'text': 'Thanks Mahmoud! Please note the building elevator is on the right side of the main lobby.',
      'createdAt': Timestamp.fromDate(now.subtract(const Duration(minutes: 10))),
      'readAt': null,
    });

    await messagesRef.add({
      'senderId': uid,
      'text': 'I have the standard brass joints ready. Arriving in ~15 minutes.',
      'createdAt': Timestamp.fromDate(now.subtract(const Duration(minutes: 5))),
      'readAt': Timestamp.fromDate(now.subtract(const Duration(minutes: 4))),
    });

    await messagesRef.add({
      'senderId': 'seed_customer',
      'text': 'Perfect, the front gate is open.',
      'createdAt': Timestamp.fromDate(now.subtract(const Duration(minutes: 2))),
      'readAt': null,
    });
  }
}