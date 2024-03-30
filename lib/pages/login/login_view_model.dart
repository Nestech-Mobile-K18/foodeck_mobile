import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/home/home_view.dart';
import 'package:template/resources/error_strings.dart';
import 'package:template/services/errror.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel {
  final supabase = Supabase.instance.client;
  final fb = FacebookAuth.instance;
  final ErrorDialog showError = ErrorDialog();
  late Map<dynamic, dynamic> _userData;

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

  Future<AuthResponse> googleSignIn(BuildContext context) async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '547586025833-sp8945f1cgsf64u3jecq1id14i7gheka.apps.googleusercontent.com';
    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      // clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw ErrorString.errorNoAccessTokenFound;
    }
    if (idToken == null) {
      throw ErrorString.errorNoIDTokenFound;
    }
    final response = supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    Map<String, dynamic> userData = {
      'email': googleUser.email,
      'name': googleUser.displayName,
    };
    if (userData.isNotEmpty) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomeView()));
    }
    await supabase.from('users').upsert(userData);

    await handleSuccessfulLogin();

    return response;
  }

  Future<void> facebookSignIn(BuildContext context) async {
    try {
      // Create an instance of FacebookLogin
      final result =
          await FacebookAuth.i.login(permissions: ['email', 'public_profile']);
      if (result.status == LoginStatus.success) {
        final requestData =
            await FacebookAuth.i.getUserData(fields: "email, name");
        _userData = {
          'email': requestData['email'],
          'name': requestData['name'],
        };
        final AccessToken? accessToken = result.accessToken;
        await supabase.auth.signInWithOAuth(
          OAuthProvider.facebook,
        );
        await supabase.from('users').upsert(_userData);
        if (_userData.isNotEmpty) {
          await handleSuccessfulLogin();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeView()));
        }
      } else if (result.status == LoginStatus.cancelled) {
        showError.showError(context, ErrorString.errorCancelLoginFacebook);
      } else {
        showError.showError(context, ErrorString.cantAccessFacebook);
      }
    } catch (e) {
      print(e);
      showError.showError(context, ErrorString.errorOccurredLogIn);
    }
  }

  Future<void> appleSignIn(BuildContext context) async {
    showError.showError(context, ErrorString.doesNotSupportApple);
  }
}
