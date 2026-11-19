import '../entities/technician_profile_entity.dart';

abstract class TechnicianProfileRepository {
  Future<TechnicianProfileEntity> getProfile();
}
