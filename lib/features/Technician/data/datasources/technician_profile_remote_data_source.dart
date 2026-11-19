import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/technician_profile_model.dart';

abstract class TechnicianProfileRemoteDataSource {
  Future<TechnicianProfileModel> getProfile();
}

class TechnicianProfileRemoteDataSourceImpl
    implements TechnicianProfileRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  TechnicianProfileRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<TechnicianProfileModel> getProfile() async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) {
      throw Exception('No logged-in user. Please login first.');
    }

    final document = await firestore.collection('users').doc(uid).get();
    if (!document.exists) {
      throw Exception('User data not found');
    }

    return TechnicianProfileModel.fromJson({
      ...document.data()!,
      'id': uid,
    });
  }
}
