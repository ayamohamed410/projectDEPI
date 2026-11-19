import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpCustomerUseCase {
  final AuthRepository repository;

  SignUpCustomerUseCase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    return repository.signUpCustomer(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
  }
}