import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// Login
class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

// Customer Sign Up
class SignUpCustomerRequested extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;

  const SignUpCustomerRequested({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, phone, password];
}

// Technician Sign Up
class SignUpTechnicianRequested extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String specialization;
  final String experience;

  const SignUpTechnicianRequested({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.specialization,
    required this.experience,
  });

  @override
  List<Object?> get props => [
    name,
    email,
    phone,
    password,
    specialization,
    experience,
  ];
}

// Logout
class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}