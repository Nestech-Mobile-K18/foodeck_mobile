part of 'authentication_bloc.dart';

sealed class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {
  // final String userId;
  // final String? password;
  final bool loading;
  final bool isLogin;
  // final String name;
  // final String? phone;
  // final String? avatar;
  // final String? typeAuthen;
  final AccountInfo? userInfor;

  AuthenticationInitial(
      {
      //   this.userId = '',
      // this.password = '',
      this.loading = false,
      this.isLogin = false,
      // this.name = '',
      // this.phone = '',
      // this.avatar = '',
      // this.typeAuthen = '',
      this.userInfor});
}

class AuthenticationInProgress extends AuthenticationState {
  final bool loading;

  AuthenticationInProgress({this.loading = true});
}

class AuthenticationSuccess extends AuthenticationState {
  final bool isLogin;
  // final String userId;
  // final String? password;
  // final String name;
  // final String? phone;
  // final String? avatar;
  // final String? typeAuthen;
  final AccountInfo? userInfor;


  AuthenticationSuccess({
    this.isLogin = true,
    // required this.userId,
    // this.password,
    // required this.name,
    // this.phone,
    // this.avatar,
    // this.typeAuthen,
    this.userInfor
  });
}

class AuthenticationFailure extends AuthenticationState {
  // final bool isLogin;
  // final String userId;
  // final String? password;
  // final String name;
  // final String? phone;
  // final String? avatar;
  // final String? typeAuthen;
  final AccountInfo? userInfor;


  AuthenticationFailure({
    // this.isLogin = false,
    // this.userId = '',
    // this.password = '',
    // this.name = '',
    // this.phone = '',
    // this.avatar = '',
    // this.typeAuthen = '',
    this.userInfor
  });
}

class AuthenticationLogOut extends AuthenticationInitial {

}

// class Authentication
class AuthenticationReset extends AuthenticationInitial {}

class AuthenticationEmailInProgress extends AuthenticationState {
  final bool loading;

  AuthenticationEmailInProgress({this.loading = true});
}

class AuthenticationEmailSuccess extends AuthenticationState {
  final bool isLogin;
  final String userId;
  final String? password;

  AuthenticationEmailSuccess(
      {this.isLogin = true, required this.userId, this.password});
}

class AuthenticationEmailFailure extends AuthenticationState {
  final bool isLogin;
  final String userId;

  AuthenticationEmailFailure({this.isLogin = false, this.userId = ''});
}
