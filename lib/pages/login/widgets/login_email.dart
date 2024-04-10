import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/login/widgets/create_account.dart';
import 'package:template/pages/login/widgets/forgot_password.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/text_styles.dart';
import 'package:template/widgets/buttons.dart';
import 'package:template/widgets/form_fill.dart';

import '../../../main.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({super.key});

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  bool showPass = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future login() async {
    try {
      await supabase.auth.signInWithPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: buttonShadowBlack, content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: buttonShadowBlack,
          content: Text('Error occurred, please retry')));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          shape: const UnderlineInputBorder(
              borderSide: BorderSide(width: 8, color: dividerGrey)),
          title: Text('Login via Email',
              style: inter.copyWith(fontSize: 17, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Input your credentials',
                      style: inter.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: CustomFormFill(
                      boxShadow: emailRegex.hasMatch(emailController.text)
                          ? Colors.pink.shade100
                          : Colors.white,
                      textInputType: TextInputType.emailAddress,
                      labelText: 'Email',
                      hintText: 'johndoe123@gmail.com',
                      exampleText: emailRegex.hasMatch(emailController.text)
                          ? null
                          : 'Example: johndoe123@gmail.com',
                      borderColor: emailController.text.isNotEmpty
                          ? globalPink
                          : Colors.grey,
                      inputColor: emailRegex.hasMatch(emailController.text)
                          ? globalPink
                          : Colors.red,
                      labelColor: emailRegex.hasMatch(emailController.text)
                          ? globalPink
                          : emailController.text.isEmpty
                              ? globalPink
                              : Colors.red,
                      focusErrorBorderColor:
                          emailRegex.hasMatch(emailController.text)
                              ? globalPink
                              : emailController.text.isEmpty
                                  ? globalPink
                                  : Colors.red,
                      textEditingController: emailController,
                      function: (value) {
                        setState(() {
                          emailRegex.hasMatch(emailController.text);
                        });
                      },
                      errorText: emailRegex.hasMatch(emailController.text)
                          ? null
                          : emailController.text.isEmpty
                              ? null
                              : '${emailController.text} is not a valid email',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomFormFill(
                      boxShadow: passRegex.hasMatch(passwordController.text)
                          ? Colors.pink.shade100
                          : Colors.white,
                      labelText: 'Password',
                      exampleText: passRegex.hasMatch(passwordController.text)
                          ? null
                          : 'Example: Johndoe123!',
                      labelColor: passRegex.hasMatch(passwordController.text)
                          ? globalPink
                          : passwordController.text.isEmpty
                              ? globalPink
                              : Colors.red,
                      inputColor: passRegex.hasMatch(passwordController.text)
                          ? globalPink
                          : Colors.red,
                      borderColor: passwordController.text.isNotEmpty
                          ? globalPink
                          : Colors.grey,
                      focusErrorBorderColor:
                          passRegex.hasMatch(passwordController.text)
                              ? globalPink
                              : passwordController.text.isEmpty
                                  ? globalPink
                                  : Colors.red,
                      icons: passwordController.text.isEmpty
                          ? const SizedBox()
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                              icon: Icon(
                                showPass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color:
                                    passRegex.hasMatch(passwordController.text)
                                        ? globalPink
                                        : Colors.red,
                              )),
                      obscureText: showPass ? false : true,
                      function: (value) {
                        setState(() {
                          passRegex.hasMatch(passwordController.text);
                        });
                      },
                      errorText: passRegex.hasMatch(passwordController.text)
                          ? null
                          : passwordController.text.isEmpty
                              ? null
                              : 'Need number, symbol, capital and small letter',
                      textEditingController: passwordController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Get.to(() => const ForgotPassword(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 600));
                      },
                      child: Text(
                        'Forgot Password?',
                        style: inter.copyWith(
                            fontSize: 13, decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  CustomButton(
                      onPressed: () {
                        login();
                      },
                      text: Text('Login',
                          style: inter.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      color: globalPink),
                  CustomButton(
                      borderSide: const BorderSide(color: Colors.grey),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Get.to(() => const CreateAccount(),
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 600));
                      },
                      text: Text('Create an account instead',
                          style: inter.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      color: Colors.white)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
