part of 'signup_bloc.dart';

sealed class SignupEvent {}

class SignUpStarted extends SignupEvent {
  SignUpStarted({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  final String email;
  final String password;
  final String name;
  final String phone;
}

class VerifyStarted extends SignupEvent {
  VerifyStarted({
    required this.email,
    required this.token,
  });

  final String email;
  final String token;
}
