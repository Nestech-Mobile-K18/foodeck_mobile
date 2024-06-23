part of 'signup_bloc.dart';

sealed class SignupState {}

class SignupInitial extends SignupState {
  final String email;
  final String password;
  final String phone;
  final String name;
  final bool loading;
  final bool isVerify;
  final bool isSuccess;

  SignupInitial(
      {this.phone = '',
      this.name = '',
      this.email = '',
      this.password = '',
      this.loading = false,
      this.isSuccess = false,
      this.isVerify = false});
}

class SignupInProgress extends SignupState {
  final bool loading;

  SignupInProgress({this.loading = true});
}

class VerifyInProgress extends SignupState {
  final bool isVerify;
  final String email;

  VerifyInProgress({this.isVerify = true, required this.email});
}

class VerifySuccess extends SignupState {
  final bool isVerify;
  final String email;

  VerifySuccess({this.isVerify = true, required this.email});
}

class SignupSuccess extends SignupState {
  final bool isLogin;

  SignupSuccess({this.isLogin = true});
}

class SignupFailure extends SignupState {
  final bool isLogin;
  final bool isVerify;

  SignupFailure(
      {this.isLogin = false, this.isVerify = false});
}

// class Signup
class SignupReset extends SignupInitial {}
