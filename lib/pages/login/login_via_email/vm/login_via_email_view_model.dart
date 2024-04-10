import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/home/view/home_view.dart';
import 'package:template/resources/validation.dart';
import 'package:template/pages/login/login_via_email/models/login_via_email_model.dart';

import '../../../application/views/application_view.dart';

class LogInViaEmailViewModel {
  final supabase = Supabase.instance.client;
  final Validation _validation = Validation();

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

  Future<AuthResponse?> signInWithEmail(
      LoginViaEmailModel loginRequest, BuildContext context) async {
    AuthResponse res;
    try {
      res = await supabase.auth.signInWithPassword(
        email: loginRequest.email.toString(),
        password: loginRequest.password.toString(),
      );

      if (res.user != null) {
        await handleSuccessfulLogin();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/application', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('email or password is incorrect'),
          ),
        );
      }
    } catch (error) {
      // Xử lý lỗi ở đây
      String errorMessage = 'An error occurred during sign-in';
      print('Error during sign-in: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
      // Trả về một AuthResponse với trường error được gán giá trị từ ngoại lệ
      return null;
    }
    return res;
  }

  void loginAuthen(BuildContext context, LoginViaEmailModel input) {
    if (!_validation.isEmailValid(input.email)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email không hợp lệ'),
      ));
    } else if (!_validation.isPasswordValid(input.password)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Mật khẩu không hợp lệ, Phải ít nhất 1 chữ hoa, 1 chữ thường và 1 kí tự đặc biệt'),
      ));
    }
  }
}
