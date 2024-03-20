import 'package:flutter/material.dart';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/home/home_view.dart';

class LoginViewModel {
  final supabase = Supabase.instance.client;

  void _setupAuthListener(BuildContext context) {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    });
  }

  Future<AuthResponse> googleSignIn() async {
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
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final fb = FacebookLogin();
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);
      final FacebookAccessToken? accessToken = res.accessToken;
      if (accessToken != null) {
        final response = await supabase.auth.signInWithIdToken(
            provider: OAuthProvider.facebook,
            accessToken: accessToken.toString(),
            idToken: '');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Không thể lấy AccessToken từ Facebook!'),
        ));
      }
    } catch (e) {
      // Xử lý ngoại lệ nếu có
      print('Đã xảy ra lỗi khi đăng nhập: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Đã xảy ra lỗi khi đăng nhập!'),
      ));
    }
  }
}
