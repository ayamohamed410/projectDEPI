import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> signUpCustomer({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  Future<UserEntity> signUpTechnician({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String specialization,
    required String experience,
  });

  Future<void> logout();
}