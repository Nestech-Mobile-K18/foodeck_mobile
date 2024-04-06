import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/resources/error_strings.dart';
import 'package:template/resources/validation.dart';
import 'package:template/pages/login/login_via_email/models/login_via_email_model.dart';
import 'package:template/services/api.dart';

import '../../../../services/errror.dart';

class LogInViaEmailViewModel {
  final Validation _validation = Validation();
  final ErrorDialog _showError = ErrorDialog();
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

  Future<void> signInWithEmail(
      LoginViaEmailModel loginRequest, BuildContext context) async {
    try {
      _api.requestSignInWithEmail(
          loginRequest.email.toString(), loginRequest.password.toString());

      await handleSuccessfulLogin();
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/application', (route) => false);
    } catch (error) {
      String errorMessage = 'An error occurred during sign-in';
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  void loginAuthen(BuildContext context, LoginViaEmailModel input) {
    if (!_validation.isEmailValid(input.email)) {
      _showError.showError(context, ErrorString.invalidEmail);
    } else if (!_validation.isPasswordValid(input.password)) {
      _showError.showError(context, ErrorString.invalidPassword);
    } else {
      signInWithEmail(input, context);
    }
  }
}
