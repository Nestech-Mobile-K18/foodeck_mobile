import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/main.dart';
import 'package:template/src/features/auth/data/model.dart';

class AuthenticationService {
  // login with email
  Future<String?> loginEmail(AuthEmailRequest request) async {
    try {
      var response = await supabase.auth
          .signInWithPassword(email: request.email, password: request.password);
      return response.session?.user.id;
    } catch (error) {
      print('Failed to register user: $error');

      return null;
    }
  }

  //login with google
  Future<User?> loginWithGoogle() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      // La Android hoac IOS
      const webClientId =
          '915077099112-c8i6upjieoerckc59so2tftq18kjit2d.apps.googleusercontent.com';
      const iosClientId =
          '915077099112-bs6c6v77sttmf9h7uqq10httd9mujs2q.apps.googleusercontent.com';

      // Google sign in on Android will work without providing the Android
      // Client ID registered on Google Cloud.

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
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

      try {
        var response = await supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,
        );

        return response.session?.user;
      } on AuthException catch (error) {
        print('Failed to register user: $error');
        return null;
      } catch (error) {
        print('Failed to register user: $error');
        return null;
      }
    } else {
      // Web
      final completer = Completer<User?>(); // Completer to await the userId

      await supabase.auth.signInWithOAuth(OAuthProvider.google);
      supabase.auth.onAuthStateChange.listen((data) {
        final user = data.session?.user;
        completer.complete(user); // Complete the completer with the userId
      });

      final User? userId =
          await completer.future; // Await the completer's future
      print('user id: $userId');

      return userId;
    }
  }

  // check status is login
  Future<User?> isLogin() async {
    User? user;
    try {
      final completer =
          Completer<User?>(); // Completer to await the first event

      final StreamSubscription<dynamic> subscription =
          supabase.auth.onAuthStateChange.listen((data) {
        print('data ${data.session}');
        user = data.session?.user;

        completer.complete(user); // Complete the completer with the id
      });

      final User? result =
          await completer.future; // Await the completer's future
      subscription
          .cancel(); // Cancel the subscription after completing the future
      return result;
    } catch (error) {
      return null;
    }
  }

  Future<void> logOut() async {
    try {
      // TH dang nhap GG, Gmail
      await GoogleSignIn().signOut();
      await supabase.auth.signOut();
    } catch (error) {
      throw ('Log out fail');
    }
  }

  //login with google
  Future<String?> loginWithFacebook() async {
    final result = await FacebookAuth.i.login(permissions: [
      'email',
      'public_profile'
    ]).then((value) => {FacebookAuth.i.getUserData(fields: "email, name")});
    return null;
  }
}
