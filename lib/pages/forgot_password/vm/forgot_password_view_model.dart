import 'package:flutter/material.dart';
import 'package:template/pages/login/login_via_email/views/login_via_email_view.dart';
import 'package:template/resources/validation.dart';
import 'package:template/services/api.dart';
import 'package:template/services/errror.dart';
import 'package:template/services/table_supbase.dart';

import '../../otp/views/otp_view.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final API _api = API();
  final Validation _validation = Validation();
  final ErrorDialog _showError = ErrorDialog();

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      // Check if the email already exists on Supabase
      var res = _api.requestSelected(
          TableSupabase.usersTable, TableSupabase.emailColumn);

      res.then((value) {
        if (value!.isEmpty) {
          // If email does not exist, display an error message
          _showError.showError(context, 'You have not entered your email yet');
        } else {
          var records = value.toList();
          for (var record in records) {
            var userEmail = record['email'];
            if (userEmail != email) {
              // ignore: use_build_context_synchronously
              _showError.showError(context, 'Email not registered');
            } else {
              _api.requestResetPasswordForEmail(email);
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OtpView(
                        email: email,
                        fromHomeScreen: false,
                      )));
            }
          }
        }
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showError.showError(context, 'Please OTP code expires in 60 seconds');
    }
  }

  void validReset(BuildContext context, String email) {
    if (email.isEmpty) {
      _showError.showError(context, 'Email cannot be blank');
    } else {
      if (!_validation.isEmailValid(email.trim())) {
        _showError.showError(context, 'Email invalid');
      } else {
        resetPassword(email.trim(), context);
      }
    }
  }

  Future<void> updatePassword(
      String email, String newPassword, BuildContext context) async {
    try {
      Map<String, String>? updateData = {
        'password': newPassword,
      };
      _api.requestUpdate(
          tableSupabase: TableSupabase.usersTable,
          updateData: updateData,
          nameColumn: TableSupabase.emailColumn,
          equalString: email);
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showError.showError(context, 'Something went wrong, please try again');
    }
  }

  void validNewPassword(
      BuildContext context, String newPassword, String email) {
    if (newPassword.isEmpty) {
      _showError.showError(context, 'Mật khẩu không được để trống');
    } else {
      if (!_validation.isPasswordValid(newPassword)) {
        _showError.showError(context,
            'Invalid password, Must have at least 1 uppercase letter, 1 lowercase letter and 1 special character');
      } else {
        updatePassword(email, newPassword, context);
        Navigator.of(context).push(
            MaterialPageRoute(builder: ((context) => LoginViaEmailView())));
      }
    }
  }
}
