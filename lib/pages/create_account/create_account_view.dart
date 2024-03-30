import 'package:flutter/material.dart';
import 'package:template/pages/create_account/create_account_model.dart';
import 'package:template/pages/create_account/create_account_view_model.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/method_button.dart';
import 'package:template/widgets/cross_bar.dart';
import 'package:template/widgets/custom_button.dart';
import 'package:template/widgets/custom_text.dart';
import 'package:template/widgets/custom_textfield.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Validation _validation = Validation();
  final CreateAccountViewModel _viewModel = CreateAccountViewModel();

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      _validation.isNameValid(nameController.text);
    });
    emailController.addListener(() {
      _validation.isEmailValid(emailController.text);
    });
    phoneController.addListener(() {
      _validation.isPhoneValid(phoneController.text);
    });
    passwordController.addListener(() {
      _validation.isPasswordValid(passwordController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.removeListener(() {
      _validation.isNameValid(nameController.text);
    });
    emailController.removeListener(() {
      _validation.isEmailValid(emailController.text);
    });
    phoneController.removeListener(() {
      _validation.isPhoneValid(phoneController.text);
    });
    passwordController.removeListener(() {
      _validation.isPasswordValid(passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const CustomText(
            title: StringExtensions.createAnAccount,
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
              controller: nameController,
              title: StringExtensions.name,
              textInputType: TextInputType.name,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: emailController,
              title: StringExtensions.email,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: phoneController,
              title: StringExtensions.phone,
              textInputType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              title: StringExtensions.password,
              textInputType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  MethodButton(
                      onTap: () {
                        CreateAccountModel _signUpModel = CreateAccountModel(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          phone: phoneController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        _viewModel.auththenSignUp(_signUpModel, context);
                      },
                      color: ColorsGlobal.globalPink,
                      title: StringExtensions.createAnAccount),
                  CustomButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    color: ColorsGlobal.globalWhite,
                    title: StringExtensions.loginInstead,
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
