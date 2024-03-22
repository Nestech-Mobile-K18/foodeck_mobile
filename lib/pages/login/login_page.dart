import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/pages/login/widgets/create_account.dart';
import 'package:template/pages/login/widgets/login_email.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';
import 'package:template/widgets/buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void loginEmail() {
    Get.to(() => const LoginEmail(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 600));
  }

  void createAccount() {
    Get.to(() => const CreateAccount(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 600));
  }

  void check(String index) {
    setState(() {
      switch (index) {
        case 'Login via Email':
          loginEmail();
          break;
        case 'Create an account':
          createAccount();
          break;
        // case 2:
        //   checkBirthDay();
        //   break;
        // default:
        //   nextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(loginBackGround, fit: BoxFit.cover))),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: loginButton.length,
                        itemBuilder: (context, index) {
                          return CustomButton(
                            onPressed: () {
                              check(loginButton[index].loginText);
                            },
                            borderSide: index == loginButton.length - 1
                                ? const BorderSide(color: Colors.grey)
                                : null,
                            icons: index == loginButton.length - 1
                                ? null
                                : Image.asset(loginButton[index].type),
                            text: Text(
                              loginButton[index].loginText,
                              style: inter.copyWith(
                                  color: index == loginButton.length - 1
                                      ? Colors.grey
                                      : Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: loginButton[index].backGroundColor,
                          );
                        },
                      ),
                    ),
                    Expanded(
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text:
                                    'By signing up, you are agreeing to our\n',
                                style: inter.copyWith(
                                    fontSize: 13, color: Colors.grey),
                                children: [
                                  WidgetSpan(child: Container()),
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      text: 'Terms & Conditions',
                                      style: inter.copyWith(
                                          fontSize: 13, color: lightPink))
                                ])))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
