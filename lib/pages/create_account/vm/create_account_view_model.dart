import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/create_account/models/create_account_model.dart';
import 'package:template/pages/otp/views/otp_view.dart';
import 'package:template/resources/const.dart';

import '../../../services/errror.dart';

class CreateAccountViewModel {
  final supabase = Supabase.instance.client;
  final Validation _validation = Validation();
  final ErrorDialog _showError = ErrorDialog();

  Future<void> signUpNewUser(String emailController, String passwordController,
      BuildContext context) async {
    try {
      await supabase.auth
          .signUp(email: emailController, password: passwordController);
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showError.showError(context, 'Đã xảy ra sự cố vui lòng thử lại');
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
      };

      signUpNewUser(signUpModel.email, signUpModel.password, context);
      await supabase.from('users').insert(userData);
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showError.showError(context, 'Đã xảy ra sự cố vui lòng thử lại');
    }
  }

  void auththenSignUp(CreateAccountModel input, BuildContext context) {
    if (input.name.isEmpty ||
        input.email.isEmpty ||
        input.phone.isEmpty ||
        input.password.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Missing Information"),
            content: Text("Please fill in all the fields."),
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
