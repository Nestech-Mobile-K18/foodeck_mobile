import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:template/services/table_supbase.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/resources/error_strings.dart';
import 'package:template/services/errror.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api.dart';
import '../../application/views/application_view.dart';

class LoginViewModel {
  final fb = FacebookAuth.instance;
  final ErrorDialog showError = ErrorDialog();
  final API _api = API();

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }

  Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  Future<void> handleSuccessfulLogin() async {
    await setLoggedIn(true);
  }

  void checkLoggedIn(BuildContext context) async {
    bool isLogged = await isLoggedIn();
    if (isLogged) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/application', (route) => false);
    }
  }

  Future<AuthResponse?> googleSignIn(BuildContext context) async {
    const webClientId =
        '547586025833-sp8945f1cgsf64u3jecq1id14i7gheka.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw ErrorString.errorNoAccessTokenFound;
      }
      if (idToken == null) {
        throw ErrorString.errorNoIDTokenFound;
      }

      // Kiểm tra xem email đã tồn tại trong danh sách đăng ký hay không
      final email = googleUser.email;
      final isEmailRegistered = await _api.isEmailRegistered(email);

      if (isEmailRegistered) {
        // Hiển thị thông báo rằng email đã được đăng ký
        showError.showError(context, ErrorString.emailAlreadyRegistered);
      } else {
        // Tiếp tục xử lý đăng nhập
        final response = _api.requestSignInWithIdToken(
            OAuthProvider.google, idToken, accessToken);
        Map<String, dynamic> userData = {
          'email': email,
          'name': googleUser.displayName,
        };

        if (userData.isNotEmpty) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/application', (route) => false);
        }
        _api.requestUpSert(userData, TableSupabase.usersTable);

        await handleSuccessfulLogin();

        return response;
      }
    }
  }

  Future<void> facebookSignIn(BuildContext context) async {
    try {
      // Create an instance of FacebookLogin
      final result =
          await FacebookAuth.i.login(permissions: ['email', 'public_profile']);
      if (result.status == LoginStatus.success) {
        final requestData =
            await FacebookAuth.i.getUserData(fields: "email, name");

        Map<String, dynamic> userData = {
          'email': requestData['email'],
          'name': requestData['name'],
        };

        _api.requestSignInWithOAuth(OAuthProvider.facebook);
        _api.requestUpSert(userData, TableSupabase.usersTable);
        if (userData.isNotEmpty) {
          await handleSuccessfulLogin();
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ApplicationView()));
        }
      } else if (result.status == LoginStatus.cancelled) {
        // ignore: use_build_context_synchronously
        showError.showError(context, ErrorString.errorCancelLoginFacebook);
      } else {
        // ignore: use_build_context_synchronously
        showError.showError(context, ErrorString.cantAccessFacebook);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showError.showError(context, ErrorString.errorOccurredLogIn);
    }
  }

  Future<void> appleSignIn(BuildContext context) async {
    showError.showError(context, ErrorString.doesNotSupportApple);
  }
}
