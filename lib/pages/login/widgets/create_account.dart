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

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool showPass = false;
  final supabase = Supabase.instance.client;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  Future signUpAndAddUsers() async {
    try {
      await supabase.auth.signUp(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      await Future.delayed(const Duration(milliseconds: 100), () {
        supabase.auth.signInWithOtp(
            shouldCreateUser: false, email: emailController.text.trim());
      });
      await Future.delayed(const Duration(milliseconds: 200), () {
        supabase.from('users').insert({
          'Email': emailController.text.trim(),
          'Name': nameController.text.trim(),
          'Phone No.': phoneController.text.trim(),
          'Password': passwordController.text.trim(),
        });
      });
      await Future.delayed(const Duration(milliseconds: 300), () {
        Get.to(
            () => Otp(
                  email: emailController.text.trim(),
                ),
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 600));
      });
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error occurred, please retry')));
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
                      textInputType: TextInputType.name,
                      labelText: 'Name',
                      hintText: 'John Doe',
                      labelColor: lightPink,
                      textEditingController: nameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomFormFill(
                      textInputType: TextInputType.emailAddress,
                      labelText: 'Email',
                      hintText: 'johndoe123@gmail.com',
                      labelColor: lightPink,
                      textEditingController: emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomFormFill(
                      textInputType: TextInputType.phone,
                      labelText: 'Phone No.',
                      hintText: '+92 3014124781',
                      textInputFormatter: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      labelColor: lightPink,
                      textEditingController: phoneController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
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
                  CustomButton(
                      onPressed: () {
                        signUpAndAddUsers();
                      },
                      text: Text('Create an account',
                          style: inter.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      color: lightPink),
                  CustomButton(
                      borderSide: const BorderSide(color: Colors.grey),
                      onPressed: () {
                        Get.to(() => const LoginEmail(),
                            transition: Transition.upToDown,
                            duration: const Duration(milliseconds: 600));
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
