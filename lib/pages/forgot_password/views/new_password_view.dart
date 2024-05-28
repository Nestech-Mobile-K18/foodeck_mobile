import 'package:flutter/material.dart';
import 'package:template/pages/forgot_password/vm/forgot_password_view_model.dart';
import 'package:template/resources/const.dart';
import '../../../widgets/cross_bar.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/method_button.dart';

class NewPasswordView extends StatefulWidget {
  final String? email;
  const NewPasswordView({super.key, this.email});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final TextEditingController newPasswordController = TextEditingController();
  final ForgotPasswordViewModel _viewModel = ForgotPasswordViewModel();
  final Validation _validation = Validation();

  @override
  void initState() {
    super.initState();
    newPasswordController.addListener(() {
      _validation.isEmailValid(newPasswordController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    newPasswordController.removeListener(() {
      _validation.isEmailValid(newPasswordController.text);
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                controller: newPasswordController,
                title: StringExtensions.password,
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MethodButton(
                  onTap: () {
                    _viewModel.validNewPassword(
                        context, newPasswordController.text, widget.email!);
                  },
                  color: ColorsGlobal.globalPink,
                  title: StringExtensions.confirm),
            )
          ],
        ),
      ),
    );
  }
}
