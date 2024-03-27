import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/login/widgets/create_account.dart';
import 'package:template/pages/login/widgets/login_email.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';
import 'package:template/widgets/buttons.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void loginEmail() {
    Get.to(() => const LoginEmail(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 600));
  }

  void createAccount() {
    Get.to(() => const CreateAccount(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 600));
  }

  Future _googleSignIn() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '5627539322-gr1o01gg983mhdq7320tsnecgq0a35m4.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    // const iosClientId = 'my-ios.apps.googleusercontent.com';

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

  Future facebookSignIn() async {
    await supabase.auth.signInWithOAuth(OAuthProvider.facebook);
  }

  void check(String index) {
    setState(() {
      switch (index) {
        case 'Login via Email':
          loginEmail();
          break;
        case 'Create an account':
          createAccount();
          break;
        case 'Login via Google':
          _googleSignIn();
          break;
        case 'Login via Facebook':
          facebookSignIn();
          break;
        // default:
        //   nextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(loginBackGround, fit: BoxFit.cover))),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: loginButton.length,
                        itemBuilder: (context, index) {
                          if (index == loginButton.length - 3) {
                            return Platform.isAndroid
                                ? SizedBox()
                                : CustomButton(
                                    onPressed: () {
                                      check(loginButton[index].loginText);
                                    },
                                    borderSide: index == loginButton.length - 1
                                        ? const BorderSide(color: Colors.grey)
                                        : null,
                                    icons: index == loginButton.length - 1
                                        ? null
                                        : Image.asset(loginButton[index].type),
                                    text: Text(
                                      loginButton[index].loginText,
                                      style: inter.copyWith(
                                          color: index == loginButton.length - 1
                                              ? Colors.grey
                                              : Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: loginButton[index].backGroundColor,
                                  );
                          } else {
                            return CustomButton(
                              onPressed: () {
                                check(loginButton[index].loginText);
                              },
                              borderSide: index == loginButton.length - 1
                                  ? const BorderSide(color: Colors.grey)
                                  : null,
                              icons: index == loginButton.length - 1
                                  ? null
                                  : Image.asset(loginButton[index].type),
                              text: Text(
                                loginButton[index].loginText,
                                style: inter.copyWith(
                                    color: index == loginButton.length - 1
                                        ? Colors.grey
                                        : Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: loginButton[index].backGroundColor,
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text:
                                    'By signing up, you are agreeing to our\n',
                                style: inter.copyWith(
                                    fontSize: 13, color: Colors.grey),
                                children: [
                                  WidgetSpan(child: Container()),
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      text: 'Terms & Conditions',
                                      style: inter.copyWith(
                                          fontSize: 13, color: lightPink))
                                ])))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
