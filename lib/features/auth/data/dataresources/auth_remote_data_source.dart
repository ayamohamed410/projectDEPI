import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> signUpCustomer({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  Future<UserModel> signUpTechnician({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String specialization,
    required String experience,
  });
  Future<UserModel> signInWithGoogle();

  Future<void> logout();
}