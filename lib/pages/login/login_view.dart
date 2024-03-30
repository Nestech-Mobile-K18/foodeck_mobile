import 'package:flutter/material.dart';
import 'package:template/pages/login/login_via_email/login_via_email_view.dart';
import 'package:template/pages/login/login_view_model.dart';
import 'package:template/widgets/method_button.dart';
import 'package:template/resources/media_res.dart' as image;
import 'package:template/widgets/custom_button.dart';
import 'package:template/widgets/custom_text.dart';
import 'package:template/resources/const.dart';

import '../home/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  void _checkLoggedIn() async {
    bool isLoggedIn = await _viewModel.isLoggedIn();
    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeView(),
        ),
      );
    }
  }

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
        MethodButton(
          onTap: () async {
            await _viewModel.googleSignIn(context);
          },
          isIcon: true,
          color: ColorsGlobal.globalRed,
          title: StringExtensions.loginViaGoogle,
          assetIcon: image.MediaRes.logoGoogle,
        ),
        MethodButton(
          onTap: () async {
            await _viewModel.facebookSignIn(context);
          },
          isIcon: true,
          color: ColorsGlobal.globalBlue,
          title: StringExtensions.loginViaFacebook,
          assetIcon: image.MediaRes.logoFacebook,
        ),
        MethodButton(
          onTap: () async {
            await _viewModel.appleSignIn(context);
          },
          isIcon: true,
          color: ColorsGlobal.globalBlack,
          title: StringExtensions.loginViaApple,
          assetIcon: image.MediaRes.logoApple,
        ),
        MethodButton(
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
          title: StringExtensions.createAnAccount,
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
                softWrap: false,
                maxLine: 1,
              ),
              SizedBox(
                width: 5,
              ),
              Flexible(
                child: CustomText(
                  title: StringExtensions.termsAndConditions,
                  color: ColorsGlobal.globalPink,
                  maxLine: 2,
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
