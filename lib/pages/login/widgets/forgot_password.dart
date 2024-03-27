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
  final newEmailController = TextEditingController();
  final passwordController = TextEditingController();
  bool updatePassword = false;
  Future resetPassword() async {
    try {
      await supabase.auth
          .signInWithOtp(email: emailController.text, shouldCreateUser: false)
          .then((value) => Get.to(() => Otp(email: emailController.text),
              transition: Transition.leftToRight,
              duration: const Duration(milliseconds: 600)));
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error occurred, please retry')));
    }
  }

  Future changePassword() async {
    try {
      await supabase.auth.updateUser(UserAttributes(
          email: newEmailController.text.trim(),
          password: passwordController.text.trim()));
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
    newEmailController.dispose();
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
                          padding: const EdgeInsets.only(top: 16, bottom: 40),
                          child: updatePassword
                              ? Column(
                                  children: [
                                    CustomFormFill(
                                      textInputType: TextInputType.emailAddress,
                                      labelText: 'Email',
                                      hintText: 'johndoe123@gmail.com',
                                      labelColor: lightPink,
                                      textEditingController: newEmailController,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: CustomFormFill(
                                        labelText: 'New Password',
                                        labelColor: lightPink,
                                        textEditingController:
                                            passwordController,
                                      ),
                                    ),
                                  ],
                                )
                              : CustomFormFill(
                                  labelText: 'Email',
                                  hintText: 'johndoe123@gmail.com',
                                  labelColor: lightPink,
                                  textEditingController: emailController,
                                ),
                        ),
                        CustomButton(
                            onPressed: () {
                              updatePassword
                                  ? changePassword()
                                  : resetPassword();
                              // Get.to(() => const LoginEmail(),
                              //     transition: Transition.rightToLeft,
                              //     duration:
                              //         const Duration(milliseconds: 600));
                            },
                            text: Text(updatePassword ? 'Update' : 'Reset',
                                style: inter.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            color: lightPink)
                      ])),
            ))));
  }
}
