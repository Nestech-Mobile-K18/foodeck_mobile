import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/home/home_page.dart';
import 'package:template/pages/login/widgets/create_account.dart';
import 'package:template/pages/login/widgets/forgot_password.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/text_styles.dart';
import 'package:template/widgets/buttons.dart';
import 'package:template/widgets/form_fill.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({super.key});

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  bool showPass = false;
  final supabase = Supabase.instance.client;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final StreamSubscription<AuthState> authSubscription;
  RegExp emailRegex = RegExp(
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  Future login() async {
    try {
      if (emailRegex.hasMatch(emailController.text)) {
        await supabase.auth
            .signInWithPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .then((value) => authSubscription);
      }
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error occurred, please retry')));
    }
  }

  @override
  void initState() {
    authSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        Get.to(() => const HomePage());
      }
    });
    super.initState();
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
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
            },
          ),
          shape: const UnderlineInputBorder(
              borderSide: BorderSide(width: 8, color: primaryGrey)),
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
                      textInputType: TextInputType.emailAddress,
                      labelText: 'Email',
                      hintText: 'johndoe123@gmail.com',
                      labelColor: emailRegex.hasMatch(emailController.text)
                          ? lightPink
                          : emailController.text.isEmpty
                              ? lightPink
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
                      labelText: 'Password',
                      labelColor: lightPink,
                      icons: IconButton(
                          onPressed: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                          icon: Icon(showPass
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      obscureText: showPass ? false : true,
                      textEditingController: passwordController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const ForgotPassword(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 600));
                      },
                      child: Text(
                        'Forgot Password?',
                        style: inter.copyWith(fontSize: 13, color: Colors.grey),
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
                      color: lightPink),
                  CustomButton(
                      borderSide: const BorderSide(color: Colors.grey),
                      onPressed: () {
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
