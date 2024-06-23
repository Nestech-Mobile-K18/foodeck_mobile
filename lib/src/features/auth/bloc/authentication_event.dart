part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}

class AppStarted extends AuthenticationEvent {}


class AuthWithEmailStarted extends AuthenticationEvent {
  AuthWithEmailStarted({this.email, this.password});

  final String? email;
  final String? password;
}

class AuthWithGoogleStarted extends AuthenticationEvent {}

class AuthWithFacebookStarted extends AuthenticationEvent {}

class AuthWithAppleStarted extends AuthenticationEvent {}

 class AuthCheckStatusLoginStarted extends AuthenticationEvent{}

 class AuthLogOutStarted extends AuthenticationEvent{}
