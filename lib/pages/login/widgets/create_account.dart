import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/login/widgets/login_email.dart';
import 'package:template/pages/login/widgets/otp.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/text_styles.dart';
import 'package:template/widgets/buttons.dart';
import 'package:template/widgets/form_fill.dart';

import '../../../main.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool showPass = false;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  RegExp phoneRegex = RegExp(r'^[+]?\d{10,13}$');
  RegExp nameRegex = RegExp(
      r'^([^!@#$%^&+`;/_~*(),.?":{}|<>0-9]+\s[^!@#$%^&+`;/_~*(),.?":{}|<>0-9]+\s?[^!@#$%^&+`;/_~*(),.?":{}|<>0-9]+?\S)$');

  Future signUpAndAddUsers() async {
    try {
      await supabase.auth.signUp(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      await supabase.from('users').insert({
        'email': emailController.text.trim(),
        'full_name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'password': passwordController.text.trim(),
      });
      await Get.to(() => Otp(email: emailController.text.trim()));
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
    nameController.dispose();
    phoneController.dispose();
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
          title: Text('Create an account',
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
                        boxShadow: nameRegex.hasMatch(nameController.text)
                            ? Colors.pink.shade100
                            : Colors.white,
                        textInputType: TextInputType.name,
                        labelText: 'Full Name',
                        hintText: 'John Doe',
                        exampleText: nameRegex.hasMatch(nameController.text)
                            ? null
                            : 'Example: John Doe',
                        labelColor: nameRegex.hasMatch(nameController.text)
                            ? globalPink
                            : nameController.text.isEmpty
                                ? globalPink
                                : Colors.red,
                        borderColor: nameController.text.isNotEmpty
                            ? globalPink
                            : Colors.grey,
                        inputColor: nameRegex.hasMatch(nameController.text)
                            ? globalPink
                            : Colors.red,
                        focusErrorBorderColor:
                            nameRegex.hasMatch(nameController.text)
                                ? globalPink
                                : nameController.text.isEmpty
                                    ? globalPink
                                    : Colors.red,
                        textEditingController: nameController,
                        function: (value) {
                          setState(() {
                            nameRegex.hasMatch(nameController.text);
                          });
                        },
                        errorText: nameRegex.hasMatch(nameController.text)
                            ? null
                            : nameController.text.isEmpty
                                ? null
                                : '${nameController.text} is not a valid name'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                      boxShadow: phoneRegex.hasMatch(phoneController.text)
                          ? Colors.pink.shade100
                          : Colors.white,
                      textInputType: TextInputType.phone,
                      labelText: 'Phone No.',
                      hintText: '+92 3014124781',
                      exampleText: phoneRegex.hasMatch(phoneController.text)
                          ? null
                          : 'Need correct number',
                      textInputFormatter: [
                        LengthLimitingTextInputFormatter(13)
                      ],
                      labelColor: phoneController.text.isEmpty
                          ? globalPink
                          : phoneRegex.hasMatch(phoneController.text)
                              ? globalPink
                              : Colors.red,
                      borderColor: phoneController.text.isNotEmpty
                          ? globalPink
                          : Colors.grey,
                      inputColor: phoneRegex.hasMatch(phoneController.text)
                          ? globalPink
                          : Colors.red,
                      focusErrorBorderColor: phoneController.text.isEmpty
                          ? globalPink
                          : phoneRegex.hasMatch(phoneController.text)
                              ? globalPink
                              : Colors.red,
                      textEditingController: phoneController,
                      function: (value) {
                        setState(() {
                          phoneRegex.hasMatch(phoneController.text);
                        });
                      },
                      errorText: phoneController.text.isEmpty
                          ? null
                          : phoneRegex.hasMatch(phoneController.text)
                              ? null
                              : '${phoneController.text} is not a valid phone number',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
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
                  CustomButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        signUpAndAddUsers();
                      },
                      text: Text('Create an account',
                          style: inter.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      color: globalPink),
                  CustomButton(
                      borderSide: const BorderSide(color: Colors.grey),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Get.to(() => const LoginEmail(),
                            transition: Transition.upToDown);
                      },
                      text: Text('Login instead',
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
