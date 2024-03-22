import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/pages/login/widgets/login_email.dart';
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
              shape: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 8, color: primaryGrey)),
              title: Text('Forgot Password',
                  style: inter.copyWith(
                      fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Input your credentials',
                              style: inter.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const Padding(
                            padding: EdgeInsets.only(top: 16, bottom: 40),
                            child: CustomFormFill(
                              labelText: 'Email',
                              hintText: 'johndoe123@gmail.com',
                              labelColor: lightPink,
                            ),
                          ),
                          CustomButton(
                              onPressed: () {
                                Get.to(() => const LoginEmail(),
                                    transition: Transition.rightToLeft,
                                    duration:
                                        const Duration(milliseconds: 600));
                              },
                              text: Text('Reset',
                                  style: inter.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              color: lightPink)
                        ])))));
  }
}
