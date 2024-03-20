import 'package:flutter/material.dart';
import 'package:template/pages/login/login_via_email/login_via_email_view.dart';
import 'package:template/pages/login/login_view_model.dart';
import 'package:template/pages/login/widgets/login_method_button.dart';
import 'package:template/resources/colors.dart';
import 'package:template/resources/media_res.dart' as image;
import 'package:template/resources/scale.dart';
import 'package:template/resources/string.dart';
import 'package:template/widgets/custom_button.dart';
import 'package:template/widgets/custom_text.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginViewModel = LoginViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(image.MediaRes.backgroundLogin),
        const SizedBox(
          height: 10,
        ),
        LoginMethodButton(
          onTap: () async {
            await _loginViewModel.googleSignIn();
          },
          isIcon: true,
          color: ColorsGlobal.globalRed,
          title: StringExtensions.loginViaGoogle,
          assetIcon: image.MediaRes.logoGoogle,
        ),
        LoginMethodButton(
          onTap: () async {
            await _loginViewModel.facebookSignIn();
          },
          isIcon: true,
          color: ColorsGlobal.globalBlue,
          title: StringExtensions.loginViaFacebook,
          assetIcon: image.MediaRes.logoFacebook,
        ),
        const LoginMethodButton(
          isIcon: true,
          color: ColorsGlobal.globalBlack,
          title: StringExtensions.loginViaApple,
          assetIcon: image.MediaRes.logoApple,
        ),
        LoginMethodButton(
          isIcon: true,
          color: ColorsGlobal.globalPink,
          title: StringExtensions.loginViaEmail,
          assetIcon: image.MediaRes.logoMail,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginViaEmailView(),
            ),
          ),
        ),
        const CustomButton(
          color: ColorsGlobal.globalWhite,
          title: StringExtensions.createAcAccount,
          border: 1,
          colorTitle: ColorsGlobal.globalGrey,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          height: 65,
          width: SizeScale.screenWidth,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                title: StringExtensions.privacyAndPolicy,
                maxLine: 2,
              ),
              SizedBox(
                width: 5,
              ),
              CustomText(
                title: StringExtensions.termsAndConditions,
                color: ColorsGlobal.globalPink,
                maxLine: 2,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
