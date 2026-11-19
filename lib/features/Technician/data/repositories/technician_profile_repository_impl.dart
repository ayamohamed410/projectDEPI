import '../../domain/entities/technician_profile_entity.dart';
import '../../domain/repositories/technician_profile_repository.dart';
import '../datasources/technician_profile_remote_data_source.dart';

class TechnicianProfileRepositoryImpl implements TechnicianProfileRepository {
  final TechnicianProfileRemoteDataSource remoteDataSource;

  TechnicianProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<TechnicianProfileEntity> getProfile() {
    return remoteDataSource.getProfile();
  }
}
