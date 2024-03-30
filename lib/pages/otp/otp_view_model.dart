import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/forgot_password/new_password_view.dart';
import 'package:template/pages/home/home_view.dart';
import 'package:template/pages/otp/otp_model.dart';
import 'package:template/services/supabase/supabase_config.dart';

class OTPViewModel {
  final supabase = Supabase.instance.client;
  late Timer timer;
  int resendOTPTimer = 60;
  bool canResend = true;
  Future<void> verifyOTP(BuildContext context, OTPModel _otpModel,
      {required bool fromHomeScreen}) async {
    String token = _otpModel.otpValues.join();
    String email = _otpModel.email;
    final AuthResponse response = await supabase.auth
        .verifyOTP(token: token, type: OtpType.email, email: email);
    final User? user = response.user;
    if (user != null) {
      // ignore: use_build_context_synchronously
      if (fromHomeScreen == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => NewPasswordView(email: email),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Người dùng này không tồn tại'),
      ));
    }
  }

  void startResendOTPTimer(BuildContext context) {
    resendOTPTimer = 60; // Reset lại thời gian còn lại
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendOTPTimer == 0) {
        canResend = true;
        timer.cancel();
      } else {
        resendOTPTimer--;
        // Cập nhật UI ở đây (hoặc thông báo khi hết thời gian)
        // Ví dụ: setState(() {});
      }
    });
  }

  Future<void> resendOTP(OTPModel _otpModel, BuildContext context) async {
    try {
      await supabase.auth.signInWithOtp(
        email: _otpModel.email,
      );

      // Start the countdown
      // ignore: use_build_context_synchronously
      startResendOTPTimer(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Mã OTP có hiệu lực trong vòng 60 giây. Vui lòng đợi.')));
    }
  }
}
