import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/src/features/auth/data/model.dart';
import 'package:template/src/services/authentication_service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authService;

  AuthenticationBloc(this._authService) : super(AuthenticationInitial()) {
    on<AuthWithEmailStarted>(_onAuthWithEmailStarted);
    on<AuthWithGoogleStarted>(_onAuthWithGoogleStarted);
    on<AuthWithFacebookStarted>(_onAuthWithFAcebookStarted);
    // on<AuthWithAppleStarted>(_onSignInWithTwitterStarted);
    on<AppStarted>(_onAuthAppStarted);
    on<AuthLogOutStarted>(_onLogOutStarted);
  }

  // login with email
  Future<void> _onAuthWithEmailStarted(
      AuthWithEmailStarted event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationEmailInProgress());
    try {
      AuthEmailRequest request = AuthEmailRequest(
          email: event.email ?? '', password: event.password ?? '');

      String? response = await _authService.loginEmail(request);

      emit(AuthenticationEmailSuccess(
          userId: response!, password: event.password));
    } catch (e) {
      emit(AuthenticationEmailFailure());
    }
  }

  //login with google
  Future<void> _onAuthWithGoogleStarted(
      AuthWithGoogleStarted event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInProgress());
    try {
      User? response = await _authService.loginWithGoogle();
      print('response $response');
      AccountInfo userInfor = AccountInfo(
          avatar: response!.userMetadata?['avatar_url'],
          name: response.userMetadata?['name'],
          password: '',
          phone: response.userMetadata!['phone'],
          typeAuthen: response.appMetadata['provider'],
          email: response.userMetadata!['email'],
          userId: response.id);

      emit(AuthenticationSuccess(userInfor: userInfor
          // userId: response!.id,
          //      name: response.userMetadata!['name'],
          //     avatar: response.userMetadata!['avatar_url'],
          //     phone: response.userMetadata!['phone'],
          //     typeAuthen: response.appMetadata['provider']
          ));
    } catch (e) {
      emit(AuthenticationFailure());
    }
  }

  //check app login
  Future<void> _onAuthAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInProgress());
    try {
      User? response = await _authService.isLogin();
      print('islogin $response');
      // print('name ${response!.appMetadata['userMetadata']['name_user']}');
      // print('islogin $response');
      // print('islogin $response');
      // print('islogin $response');
      // print('islogin $response');
      // print('islogin $response');
      // print('islogin $response');

      if (response != null) {

        AccountInfo userInfor = AccountInfo(
          avatar: response!.userMetadata?['avatar_url'],
          name: response.userMetadata?['name'],
          password: '',
          phone: response.userMetadata!['phone'],
          email: response.userMetadata!['email'],

          typeAuthen: response.appMetadata['provider'],
          userId: response.id);


        emit(AuthenticationSuccess(userInfor: userInfor
            // userId: response.id,
            // name: response.userMetadata!['name'],
            // avatar: response.userMetadata!['avatar_url'],
            // phone: response.userMetadata!['phone'],
            // typeAuthen: response.appMetadata['provider']
            ));
      } else {
        emit(AuthenticationFailure());
      }
    } catch (e) {
      emit(AuthenticationFailure());
    }
  }

  //log out
  void _onLogOutStarted(
      AuthLogOutStarted event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInProgress());
    try {
      await _authService.logOut();

      emit(AuthenticationLogOut());
    } catch (e) {
      // emit(AuthenticationFailure());
    }
  }

  // login with email
  Future<void> _onAuthWithFAcebookStarted(
      AuthWithFacebookStarted event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInProgress());
    try {
      // print('login email ${event.email}');
      // AuthEmailRequest request = AuthEmailRequest(
      //     email: event.email ?? '', password: event.password ?? '');

      // String? response = await _authService.loginEmail(request);

      // emit(AuthenticationSuccess(userId: ''));
    } catch (e) {
      emit(AuthenticationFailure());
    }
  }
}
