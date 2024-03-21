import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/home/home_view.dart';

class LoginViewModel {
  final supabase = Supabase.instance.client;
  final fb = FacebookAuth.instance;
  Map? _userData;

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

  Future<AuthResponse> facebookSignIn(BuildContext context) async {
    try {
      // Create an instance of FacebookLogin
      final result =
          await FacebookAuth.i.login(permissions: ['email', 'public_profile']);
      if (result.status == LoginStatus.success) {
        final requestData =
            await FacebookAuth.i.getUserData(fields: "email, name");
        _userData = requestData;
        final AccessToken? accessToken = result.accessToken;

        // Đăng nhập với idToken lấy được
        final response = await supabase.auth.signInWithIdToken(
          provider: OAuthProvider.facebook,
          accessToken: accessToken?.token,
          idToken: accessToken!.token,
        );
        return response;
      } else if (result.status == LoginStatus.cancelled) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Người dùng đã hủy đăng nhập vào Facebook!'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Không thể truy cập vào Facebook!'),
        ));
      }
    } catch (e) {
      // Xử lý ngoại lệ nếu có
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Đã xảy ra lỗi khi đăng nhập!'),
      ));
    }

    // Trả về một giá trị mặc định nếu không thể đăng nhập thành công
    return AuthResponse(
      user: null,
      session: null,
    );
  }

  Future<void> appleSignIn(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Không thể truy cập vào Apple ID!'),
    ));
  }
}
