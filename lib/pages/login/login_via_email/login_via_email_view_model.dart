import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/home/home_view.dart';
import 'package:template/resources/validation.dart';
import 'package:template/pages/login/login_via_email/login_via_email_model.dart';

class LogInViaEmailViewModel {
  final supabase = Supabase.instance.client;
  final Validation _validation = Validation();

  Future<AuthResponse> signInWithEmail(
      LoginViaEmailModel loginRequest, BuildContext context) async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
        email: loginRequest.email.toString(),
        password: loginRequest.password.toString());
    if (res.user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeView(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Nguời dùng này không tồn tại'),
      ));
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
