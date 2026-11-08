import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_customer_usecase.dart';
import '../../domain/usecases/signup_technician_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpCustomerUseCase signUpCustomerUseCase;
  final SignUpTechnicianUseCase signUpTechnicianUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signUpCustomerUseCase,
    required this.signUpTechnicianUseCase,
    required this.logoutUseCase,
  }) : super(const AuthInitial()) {
    // Login
    on<LoginRequested>((event, emit) async {
      emit(const AuthLoading());

      try {
        final user = await loginUseCase(
          email: event.email,
          password: event.password,
        );

        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // Customer Sign Up
    on<SignUpCustomerRequested>((event, emit) async {
      emit(const AuthLoading());

      try {
        final user = await signUpCustomerUseCase(
          name: event.name,
          email: event.email,
          phone: event.phone,
          password: event.password,
        );

        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // Technician Sign Up
    on<SignUpTechnicianRequested>((event, emit) async {
      emit(const AuthLoading());

      try {
        final user = await signUpTechnicianUseCase(
          name: event.name,
          email: event.email,
          phone: event.phone,
          password: event.password,
          specialization: event.specialization,
          experience: event.experience,
        );

        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // Logout
    on<LogoutRequested>((event, emit) async {
      emit(const AuthLoading());

      try {
        await logoutUseCase();

        emit(const AuthLogoutSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}