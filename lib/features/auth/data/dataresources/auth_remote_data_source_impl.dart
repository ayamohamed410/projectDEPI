import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential =
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    final document =
    await firestore.collection('users').doc(uid).get();

    if (!document.exists) {
      throw Exception('User data not found');
    }

    return UserModel.fromJson({
      ...document.data()!,
      'id': uid,
    });
  }

  @override
  Future<UserModel> signUpCustomer({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final credential =
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    final user = UserModel(
      id: uid,
      name: name,
      email: email,
      phone: phone,
      role: 'customer',
    );

    await firestore.collection('users').doc(uid).set(
      user.toJson(),
    );

    return user;
  }

  @override
  Future<UserModel> signUpTechnician({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String specialization,
    required String experience,
  }) async {
    final credential =
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    final user = UserModel(
      id: uid,
      name: name,
      email: email,
      phone: phone,
      role: 'technician',
      specialization: specialization,
      experience: experience,
    );

    await firestore.collection('users').doc(uid).set(
      user.toJson(),
    );

    return user;
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}