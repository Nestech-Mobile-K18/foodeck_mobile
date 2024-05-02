import 'package:flutter/material.dart';
import 'package:template/pages/forgot_password/vm/forgot_password_view_model.dart';

import 'package:template/widgets/cross_bar.dart';
import 'package:template/widgets/custom_text.dart';
import 'package:template/widgets/custom_textfield.dart';
import 'package:template/widgets/method_button.dart';
import 'package:template/resources/const.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController emailController = TextEditingController();
  final Validation _validation = Validation();
  final ForgotPasswordViewModel _viewModel = ForgotPasswordViewModel();
  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      _validation.isEmailValid(emailController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.removeListener(() {
      _validation.isEmailValid(emailController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const CustomText(
            title: StringExtensions.forgotPassword,
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
                title: StringExtensions.inputYourCredentials,
                color: ColorsGlobal.globalBlack,
                fontWeight: FontWeight.w600,
                size: 20,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: emailController,
              title: StringExtensions.email,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: MethodButton(
                  onTap: () {
                    _viewModel.validReset(context, emailController.text.trim());
                  },
                  color: ColorsGlobal.globalPink,
                  title: StringExtensions.reset),
            )
          ],
        ),
      ),
    );
  }
}
