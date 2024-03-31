import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/foundation/app_platform.dart';
import 'package:template/main.dart';
import 'package:template/pages/home/home_view.dart';
import 'package:template/resources/colors.dart';
import 'package:template/resources/media_res.dart';
import 'package:template/resources/routes.dart';
import 'package:template/widgets/button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isLoading = false;
  late final StreamSubscription<AuthState> _authStateSubscription;
  late Map<dynamic, dynamic> _userData = {};
  bool _isLogin = false;
  // final ErrorDialog showError = ErrorDialog();

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      print('seession: $session');
      if (_isLogin) return;

      if (session != null) {
        _isLogin = true;
        Navigator.of(context).pushReplacementNamed('/home', arguments: null);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  Future<void> handleSuccessfulLogin() async {
    await setLoggedIn(true);
  }

  Future<void> loginWithGoogle() async {
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
        await supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Check your email for a login link!')),
          );
        }
      } on AuthException catch (error) {
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      } catch (error) {
        SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } else {
      // TH la web
      await supabase.auth.signInWithOAuth(OAuthProvider.google);
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      // Create an instance of FacebookLogin
      final result = await FacebookAuth.i
          .login(permissions: ['email', 'public_profile']).then((value) => {
                FacebookAuth.i
                    .getUserData(fields: "email, name")
                    .then((userData) async {
                  setState(() {
                    _isLogin = true;
                    _userData = {...userData, 'provider': 'facebook'};
                    print('user login: $userData');
                    Navigator.of(context)
                        .pushNamed('/home', arguments: _userData);
                  });
                })
              });
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithEmail() async {
    Navigator.of(context).pushNamed(RouteName.loginEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const Image(
            image: AssetImage(MediaRes.imgLogin),
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
          toolbarHeight: 295,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(32, 48, 32, 32),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Button(
                      label: 'Login via Google',
                      colorBackgroud: ColorsGlobal.red,
                      colorLabel: Colors.white,
                      icon: MediaRes.icGoogle,
                      width: 328,
                      height: 62,
                      onPressed: () => loginWithGoogle()),
                  Button(
                      label: 'Login via Facebook',
                      colorBackgroud: ColorsGlobal.blue,
                      colorLabel: Colors.white,
                      icon: MediaRes.icFacebook,
                      width: 328,
                      height: 62,
                      onPressed: () => signInWithFacebook()),
                  Button(
                    label: 'Login via Apple',
                    colorBackgroud: ColorsGlobal.black,
                    colorLabel: Colors.white,
                    icon: MediaRes.icApple,
                    width: 328,
                    height: 62,
                  ),
                  Button(
                      label: 'Login via Email',
                      colorLabel: Colors.white,
                      colorBackgroud: ColorsGlobal.globalPink,
                      icon: MediaRes.icMail,
                      width: 328,
                      height: 62,
                      onPressed: () => signInWithEmail()),
                  Button(
                    label: 'Create an account',
                    colorLabel: ColorsGlobal.grey,
                    colorBorder: ColorsGlobal.grey,
                    colorBackgroud: Colors.white,
                    width: 328,
                    height: 62,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 32.0),
                    child: Text(
                      'By signing up, you are agreeing to our Terms & Conditions',
                      style: TextStyle(color: ColorsGlobal.grey, fontSize: 18),
                    ),
                  )
                ]),
          ),
        ));
  }
}
