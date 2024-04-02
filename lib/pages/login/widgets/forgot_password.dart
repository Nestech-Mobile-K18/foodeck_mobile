import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/main.dart';
import 'package:template/pages/login/widgets/otp.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/text_styles.dart';
import 'package:template/widgets/buttons.dart';
import 'package:template/widgets/form_fill.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  Future login() async {
    try {
      if (emailRegex.hasMatch(emailController.text)) {
        await supabase.auth
            .signInWithOtp(email: emailController.text, shouldCreateUser: false)
            .then((value) => Get.to(() => Otp(email: emailController.text),
                transition: Transition.leftToRight,
                duration: const Duration(milliseconds: 600)));
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: buttonShadowBlack,
          content: Text('Email is not correct, please retry')));
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: buttonShadowBlack, content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: buttonShadowBlack,
          content: Text('Error occurred, please retry')));
    }
  }

  // Future changePassword() async {
  //   try {
  //     await supabase.auth.updateUser(UserAttributes(
  //         email: newEmailController.text.trim(),
  //         password: passwordController.text.trim()));
  //   } on AuthException catch (error) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(error.message)));
  //   } catch (error) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Error occurred, please retry')));
  //   }
  // }

  @override
  void dispose() {
    emailController.dispose();
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
              shape: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 8, color: dividerGrey)),
              title: Text('Forgot Password',
                  style: inter.copyWith(
                      fontSize: 17, fontWeight: FontWeight.bold)),
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
                          padding: const EdgeInsets.only(top: 16, bottom: 20),
                          child: CustomFormFill(
                              textInputType: TextInputType.emailAddress,
                              labelText: 'Email',
                              hintText: 'johndoe123@gmail.com',
                              exampleText: 'Example: johndoe123@gmail.com',
                              labelColor:
                                  emailRegex.hasMatch(emailController.text)
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
                              errorText: emailRegex
                                      .hasMatch(emailController.text)
                                  ? null
                                  : emailController.text.isEmpty
                                      ? null
                                      : '${emailController.text} is not a valid email'),
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
                            color: globalPink)
                      ])),
            ))));
  }
}
