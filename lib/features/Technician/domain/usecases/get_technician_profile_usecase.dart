import '../entities/technician_profile_entity.dart';
import '../repositories/technician_profile_repository.dart';

class GetTechnicianProfileUseCase {
  final TechnicianProfileRepository repository;
  GetTechnicianProfileUseCase(this.repository);

  Future<TechnicianProfileEntity> call() => repository.getProfile();
}
