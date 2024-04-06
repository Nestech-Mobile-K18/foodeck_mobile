import 'package:flutter/material.dart';
import 'package:template/pages/create_account/views/create_account_view.dart';
import 'package:template/pages/login/login_via_email/views/login_via_email_view.dart';
import 'package:template/pages/login/vm/login_view_model.dart';
import 'package:template/pages/login/widgets/deep_link.dart';
import 'package:template/widgets/method_button.dart';
import 'package:template/resources/media_res.dart' as image;
import 'package:template/widgets/custom_button.dart';
import 'package:template/widgets/custom_text.dart';
import 'package:template/resources/const.dart';

import '../../home/view/home_view.dart';

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
    _viewModel.checkLoggedIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            CustomButton(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateAccountView(),
                ),
              ),
              color: ColorsGlobal.globalWhite,
              title: StringExtensions.createAnAccount,
              border: 1,
              colorTitle: ColorsGlobal.globalGrey,
            ),
            const SizedBox(
              height: 10,
            ),
            const DeepLink()
          ],
        ));
  }
}
