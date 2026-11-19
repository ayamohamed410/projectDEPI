import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../dataresources/auth_remote_data_source.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) {
    return remoteDataSource.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserEntity> signUpCustomer({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    return remoteDataSource.signUpCustomer(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
  }

  @override
  Future<UserEntity> signUpTechnician({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String specialization,
    required String experience,
  }) {
    return remoteDataSource.signUpTechnician(
      name: name,
      email: email,
      phone: phone,
      password: password,
      specialization: specialization,
      experience: experience,
    );
  }
  Future<UserEntity> signInWithGoogle() {
    return remoteDataSource.signInWithGoogle();
  }
  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }
}