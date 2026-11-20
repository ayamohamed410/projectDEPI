import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'data/datasources/technician_profile_remote_data_source.dart';
import 'data/repositories/technician_profile_repository_impl.dart';
import 'domain/usecases/get_technician_profile_usecase.dart';
import 'presentation/bloc/profile/profile_bloc.dart';

class TechnicianDependencies {
  static ProfileBloc getProfileBloc() {
    final remoteDataSource = TechnicianProfileRemoteDataSourceImpl(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    );

    final repository =
        TechnicianProfileRepositoryImpl(remoteDataSource: remoteDataSource);

    return ProfileBloc(
      getProfileUseCase: GetTechnicianProfileUseCase(repository),
    );
  }
}
