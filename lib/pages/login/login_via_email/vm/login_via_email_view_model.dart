import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:template/resources/error_strings.dart';
import 'package:template/resources/validation.dart';
import 'package:template/pages/login/login_via_email/models/login_via_email_model.dart';
import 'package:template/services/api.dart';

import '../../../../services/auth_manager.dart';
import '../../../../services/errror.dart';

class LogInViaEmailViewModel extends ChangeNotifier {
  final Validation _validation = Validation();
  final ErrorDialog _showError = ErrorDialog();
  final API _api = API();

  void checkLoggedIn(BuildContext context) async {
    bool isLogged = await AuthManager.isLoggedIn();
    if (isLogged) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/application', (route) => false);
    }
  }

  Future<void> signInWithEmail(
      LoginViaEmailModel loginRequest, BuildContext context) async {
    try {
      await _api.requestSignInWithEmail(
          loginRequest.email.toString(), loginRequest.password.toString());

      await AuthManager.handleSuccessfulLogin();
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