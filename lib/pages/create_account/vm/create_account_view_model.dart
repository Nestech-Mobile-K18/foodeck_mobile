import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/create_account/models/create_account_model.dart';
import 'package:template/pages/otp/views/otp_view.dart';
import 'package:template/resources/const.dart';
import 'package:template/services/api.dart';
import 'package:template/services/table_supbase.dart';

import '../../../resources/error_strings.dart';
import '../../../services/errror.dart';

class CreateAccountViewModel extends ChangeNotifier {
  final Validation _validation = Validation();
  final ErrorDialog _showError = ErrorDialog();
  final API _api = API();

  Future<AuthResponse?> signUpNewUser(String emailController,
      String passwordController, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      final res = _api.requestSignUp(
          email: emailController, password: passwordController);

      res.then((value) {
        if (value?.session?.user.id == null) {
          _showError.showError(context, 'Đã xảy ra sự cố vui lòng thử lại');
        } else {
          _showError.showError(context, 'Đăng kí thành công');
        }
      });
      return res;
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showError.showError(context, 'Đã xảy ra sự cố vui lòng thử lại');
      return null;
    }
  }

  Future<void> pushInformation(
      CreateAccountModel signUpModel, BuildContext context) async {
    try {
      Map<String, dynamic> userData = {
        'email': signUpModel.email,
        'name': signUpModel.name,
        'phone': signUpModel.phone,
        'password': signUpModel.password,
        'provider': 'Email'
      };

      signUpNewUser(signUpModel.email, signUpModel.password, context);
      _api.requestInsert(
          tableSupabase: TableSupabase.usersTable, userData: userData);
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showError.showError(context, 'Đã xảy ra sự cố vui lòng thử lại');
    }
  }

  void auththenSignUp(CreateAccountModel input, BuildContext context) async {
    if (input.name.isEmpty ||
        input.email.isEmpty ||
        input.phone.isEmpty ||
        input.password.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Missing Information"),
            content: const Text("Please fill in all the fields."),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          );
        },
      );
    } else {
      if (!_validation.isNameValid(input.name)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid name !'),
          backgroundColor: ColorsGlobal.globalPink,
        ));
      } else if (!_validation.isEmailValid(input.email)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid email !'),
        ));
      } else if (!_validation.isPhoneValid(input.phone)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('invalid phone number !'),
        ));
      } else if (!_validation.isPasswordValid(input.password)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Invalid password, Must have at least 1 uppercase letter, 1 lowercase letter and 1 special character'),
        ));
      } else {
        // Check if email has been registered or not
        bool emailRegistered =
            await _api.isEmailRegisteredByGoogle(input.email);
        if (emailRegistered) {
          // If email is already registered, display an error message
          _showError.showError(context, ErrorString.emailAlreadyRegistered);
        } else {
          // If email is not registered, proceed with registration
          pushInformation(input, context);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  OtpView(email: input.email, fromHomeScreen: true),
            ),
          );
        }
      }
    }
  }
}
