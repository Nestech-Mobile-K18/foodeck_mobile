import 'package:flutter/material.dart';
import 'package:template/pages/login/widgets/login_method_button.dart';
import 'package:template/widgets/cross_bar.dart';
import 'package:template/resources/colors.dart';
import 'package:template/resources/string.dart';
import 'package:template/widgets/custom_button.dart';
import 'package:template/widgets/custom_text.dart';
import 'package:template/widgets/custom_textfield.dart';

class LoginViaEmailView extends StatefulWidget {
  const LoginViaEmailView({Key? key}) : super(key: key);

  @override
  State<LoginViaEmailView> createState() => _LoginViaEmailViewState();
}

class _LoginViaEmailViewState extends State<LoginViaEmailView> {
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
                title: StringExtensions.titleLoginViaEmail,
                color: ColorsGlobal.globalBlack,
                fontWeight: FontWeight.w600,
                size: 20,
              ),
            ),
            const SizedBox(height: 10),
            const CustomTextField(
              title: StringExtensions.email,
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              title: StringExtensions.password,
              obscureText: true,
            ),
            const SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(left: 25),
              child: GestureDetector(
                child: const CustomText(
                  title: StringExtensions.forgotPassword,
                  size: 13,
                  color: ColorsGlobal.globalGrey,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  LoginMethodButton(
                      color: ColorsGlobal.globalPink,
                      title: StringExtensions.login),
                  CustomButton(
                    color: ColorsGlobal.globalWhite,
                    title: StringExtensions.createAcAccountInstead,
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
