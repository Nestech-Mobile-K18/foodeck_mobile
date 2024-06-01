import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:template/pages/otp/models/otp_model.dart';
import 'package:template/services/api.dart';

import '../../../services/errror.dart';

import '../../forgot_password/views/new_password_view.dart';

/// A view model for managing OTP-related data and interactions.
class OTPViewModel {
  /// Timer object for handling OTP resend countdown.
  Timer? timer;

  /// Time left for OTP resend countdown.
  int resendOTPTimer = 60;

  /// Flag indicating whether OTP can be resent.
  bool canResend = true;

  /// An instance of the API class for making API requests.
  final API _api = API();

  /// An instance of the ErrorDialog class for displaying error messages.
  final ErrorDialog _showError = ErrorDialog();

  Future<void> _saveUserIdToSharedPreferences(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  Future<String?> _getUserIdFromSupabase(String email) async {
    var response = await _api.supabase
        .from('users')
        .select('id')
        .eq('email', email)
        .single();

    String? userId = response['id'];

    return userId;
  }

  /// Verifies the OTP code entered by the user.
  Future<void> verifyOTP(BuildContext context, OTPModel otpModel,
      {required bool fromHomeScreen}) async {
    try {
      String token = otpModel.otpValues.join();
      String email = otpModel.email;

      final res = await _api.requestVerifyOTP(
          token: token, otpType: OtpType.email, email: email);

      if (res?.user != null) {
        final User? user = res?.user;
        if (user != null) {
          if (fromHomeScreen) {
            final String? userId = await _getUserIdFromSupabase(email);
            if (userId != null) {
              await _saveUserIdToSharedPreferences(userId);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/application', (route) => false);
            } else {
              _showError.showError(context, 'This user does not exist');
            }
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => NewPasswordView(email: email),
              ),
            );
          }
        } else {
          _showError.showError(context, 'This user does not exist');
        }
      } else {
        _showError.showError(context, 'OTP code is incorrect');
      }
    } catch (e) {
      _showError.showError(context, 'An error occurred. Please try again.');
    }
  }

  /// Starts the OTP resend countdown timer.
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

  /// Resends the OTP code to the user.
  Future<void> resendOTP(OTPModel otpModel, BuildContext context) async {
    try {
      _api.requestResendOTP(otpModel.email);
      // Start the countdown
      startResendOTPTimer(context);
    } catch (e) {
      _showError.showError(
          context, 'The OTP code is valid within 60 seconds. Please wait.');
    }
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
  Future<void> saveUserIdToSharedPreferences(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }
  void disposeVerifyOTP() {
    timer?.cancel();
  }

}
