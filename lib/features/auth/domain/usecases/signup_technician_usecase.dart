import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpTechnicianUseCase {
  final AuthRepository repository;

  SignUpTechnicianUseCase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String specialization,
    required String experience,
  }) {
    return repository.signUpTechnician(
      name: name,
      email: email,
      phone: phone,
      password: password,
      specialization: specialization,
      experience: experience,
    );
  }
}