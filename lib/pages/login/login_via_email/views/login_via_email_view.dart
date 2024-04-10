import 'package:flutter/material.dart';
import 'package:template/pages/create_account/views/create_account_view.dart';
import 'package:template/pages/login/login_via_email/models/login_via_email_model.dart';
import 'package:template/pages/login/login_via_email/vm/login_via_email_view_model.dart';
import 'package:template/widgets/method_button.dart';
import 'package:template/widgets/cross_bar.dart';
import 'package:template/widgets/custom_button.dart';
import 'package:template/widgets/custom_text.dart';
import 'package:template/widgets/custom_textfield.dart';
import 'package:template/resources/const.dart';

import '../../../forgot_password/views/forgot_password_view.dart';

class LoginViaEmailView extends StatefulWidget {
  const LoginViaEmailView({super.key});

  @override
  State<LoginViaEmailView> createState() => _LoginViaEmailViewState();
}

class _LoginViaEmailViewState extends State<LoginViaEmailView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Validation _validation = Validation();
  final LogInViaEmailViewModel _viewModel = LogInViaEmailViewModel();

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      _validation.isEmailValid(emailController.text);
    });
    passwordController.addListener(() {
      _validation.isPasswordValid(passwordController.text);
    });
    _viewModel.checkLoggedIn(context);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.removeListener(() {
      _validation.isEmailValid(emailController.text);
    });
    passwordController.removeListener(() {
      _validation.isPasswordValid(passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const CustomText(
            title: StringExtensions.loginViaEmail,
            size: 17,
            fontWeight: FontWeight.w600,
            color: ColorsGlobal.globalBlack),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CrossBar(height: 10),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 20, 0, 10),
              child: const CustomText(
                title: StringExtensions.inputYourCredentials,
                color: ColorsGlobal.globalBlack,
                fontWeight: FontWeight.w600,
                size: 20,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: emailController,
              textInputType: TextInputType.emailAddress,
              title: StringExtensions.email,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              title: StringExtensions.password,
              textInputType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(left: 25),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgotPasswordView()));
                },
                child: const CustomText(
                  title: StringExtensions.forgotPassword,
                  size: 13,
                  color: ColorsGlobal.globalGrey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  MethodButton(
                      onTap: () {
                        if (!_validation.isEmailValid(emailController.text)) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Email không hợp lệ'),
                          ));
                        } else if (!_validation
                            .isPasswordValid(passwordController.text)) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'Mật khẩu không hợp lệ, Phải ít nhất 1 chữ hoa, 1 chữ thường và 1 kí tự đặc biệt'),
                          ));
                        } else {
                          LoginViaEmailModel loginRequest = LoginViaEmailModel(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          _viewModel.signInWithEmail(loginRequest, context);
                        }
                      },
                      color: ColorsGlobal.globalPink,
                      title: StringExtensions.login),
                  CustomButton(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateAccountView(),
                      ),
                    ),
                    color: ColorsGlobal.globalWhite,
                    title: StringExtensions.createAnAccountInstead,
                    border: 1,
                    colorTitle: ColorsGlobal.globalGrey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
