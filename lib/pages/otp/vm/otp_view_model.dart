import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:template/pages/otp/models/otp_model.dart';
import 'package:template/services/api.dart';

import '../../../services/errror.dart';

import '../../forgot_password/views/new_password_view.dart';

class OTPViewModel {
  Timer? timer;
  int resendOTPTimer = 60;
  bool canResend = true;
  final API _api = API();
  final ErrorDialog _showError = ErrorDialog();

  Future<void> verifyOTP(BuildContext context, OTPModel _otpModel,
      {required bool fromHomeScreen}) async {
    try {
      String token = _otpModel.otpValues.join();
      String email = _otpModel.email;

      final res = _api.requestVerifyOTP(
          token: token, otpType: OtpType.email, email: email);
      res.then((value) {
        final User? user = value?.user;
        if (user != null) {
          // ignore: use_build_context_synchronously
          if (fromHomeScreen == true) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/application', (route) => false);
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => NewPasswordView(email: email),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('This user does not exist'),
          ));
        }
      });
    } catch (e) {
      _showError.showError(context, 'OTP code is incorrect');
    }
  }

  void startResendOTPTimer(BuildContext context) {
    resendOTPTimer = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendOTPTimer == 0) {
        canResend = true;
        timer.cancel();
      } else {
        resendOTPTimer--;
      }
    });
  }

  Future<void> resendOTP(OTPModel _otpModel, BuildContext context) async {
    try {
      _api.requestResendOTP(_otpModel.email);
      // Start the countdown
      // ignore: use_build_context_synchronously
      startResendOTPTimer(context);
    } catch (e) {
      _showError.showError(
          context, 'The OTP code is valid within 60 seconds. Please wait.');
    }
  }
}
