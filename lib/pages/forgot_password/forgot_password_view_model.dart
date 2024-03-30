import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/login/login_via_email/login_via_email_view.dart';
import 'package:template/resources/validation.dart';
import 'package:template/services/errror.dart';

class ForgotPasswordViewModel {
  final supabase = Supabase.instance.client;
  final Validation _validation = Validation();
  final ErrorDialog _showError = ErrorDialog();

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      // Kiểm tra xem email đã tồn tại trên Supabase chưa
      final response = await supabase.auth.getUserIdentities();

      if (response.isEmpty) {
        // Nếu email không tồn tại, hiển thị thông báo lỗi
        _showError.showError(context, 'Email không tồn tại');
      } else {
        // Nếu email tồn tại, gửi yêu cầu đặt lại mật khẩu
        await supabase.auth.resetPasswordForEmail(email);
      }
    } catch (e) {
      _showError.showError(context, 'Vui lòng mã OTP hết hiệu lực trong 60s');
    }
  }

  void validReset(BuildContext context, String email) {
    if (email.isEmpty) {
      _showError.showError(context, 'Email không được để trống');
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
      await supabase.from('users').update(updateData).eq('email', email);
    } catch (e) {
      _showError.showError(context, 'Đã xảy ra sự cố vui lòng thử lại');
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
