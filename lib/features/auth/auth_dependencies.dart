import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'data/dataresources/auth_remote_data_source.dart';
import 'data/dataresources/auth_remote_data_source_impl.dart';
import 'data/repositories/auth_repository_impl.dart';

import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/signup_customer_usecase.dart';
import 'domain/usecases/signup_technician_usecase.dart';
import 'domain/usecases/logout_usecase.dart';

import 'presentation/bloc/auth_bloc.dart';

class AuthDependencies {
  static AuthBloc getAuthBloc() {
    // Firebase
    final firebaseAuth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    // Data Source
    final AuthRemoteDataSource remoteDataSource =
    AuthRemoteDataSourceImpl(
      firebaseAuth: firebaseAuth,
      firestore: firestore,
    );

    // Repository
    final AuthRepository repository = AuthRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );

    // Use Cases
    final loginUseCase = LoginUseCase(repository);
    final signUpCustomerUseCase = SignUpCustomerUseCase(repository);
    final signUpTechnicianUseCase =
    SignUpTechnicianUseCase(repository);
    final logoutUseCase = LogoutUseCase(repository);

    // BLoC
    return AuthBloc(
      loginUseCase: loginUseCase,
      signUpCustomerUseCase: signUpCustomerUseCase,
      signUpTechnicianUseCase: signUpTechnicianUseCase,
      logoutUseCase: logoutUseCase,
    );
  }
}