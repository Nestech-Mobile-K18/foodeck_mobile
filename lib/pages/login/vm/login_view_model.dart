import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:template/services/table_supbase.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/resources/error_strings.dart';
import 'package:template/services/errror.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api.dart';
import '../../../services/auth_manager.dart';
import '../../application/views/application_view.dart';

class LoginViewModel extends ChangeNotifier {
  final fb = FacebookAuth.instance;
  final ErrorDialog showError = ErrorDialog();
  final API _api = API();

  void checkLoggedIn(BuildContext context) async {
    bool isLogged = await AuthManager.isLoggedIn();
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

      final email = googleUser.email;
      final isEmailRegistered = await _api.isEmailRegisteredByEmail(email);

      if (isEmailRegistered) {
        showError.showError(context, ErrorString.emailAlreadyRegistered);
      } else {
        final response = _api.requestSignInWithIdToken(
            OAuthProvider.google, idToken, accessToken);
        Map<String, dynamic> userData = {
          'email': email,
          'name': googleUser.displayName,
          'provider': 'Google'
        };

        if (userData.isNotEmpty) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/application', (route) => false);
        }
        _api.requestUpsert(userData, TableSupabase.usersTable);

        await AuthManager.handleSuccessfulLogin();

        return response;
      }
    }
    return null;
  }

  Future<void> saveUserIdToSharedPreferences(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  Future<String?> getUserIdFromSupabase(String email) async {
    var response = await _api.supabase
        .from('users')
        .select('id')
        .eq('email', email)
        .single();

    String? userId = response['id'];

    return userId;
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
          'provider': 'Facebook'
        };

        _api.requestSignInWithOAuth(OAuthProvider.facebook);
        _api.requestUpsert(userData, TableSupabase.usersTable);
        if (userData.isNotEmpty) {
          await AuthManager.handleSuccessfulLogin();
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ApplicationView()));
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
