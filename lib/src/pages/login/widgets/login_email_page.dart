import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/features/auth/bloc/authentication_bloc.dart';
import 'package:template/src/pages/export.dart';
import 'package:template/src/utils/validate/validate_operations.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({Key? key}) : super(key: key);

  @override
  _LoginEmailPageState createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  late FocusNode _focusNodeEmail;
  late FocusNode _focusNodePassword;

  @override
  void initState() {
    _focusNodeEmail = FocusNode();
    _focusNodePassword = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _mailController.dispose();
    _passController.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  Future<void> loginEmail() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final mail = _mailController.text.trim();
      final pass = _passController.text.trim();
      context
          .read<AuthenticationBloc>()
          .add(AuthWithEmailStarted(email: mail, password: pass));
    }
  }

  Future<void> signupEmail() async {
    GoRouter.of(context).push(RouteName.signup);
  }

  Widget loginEmailWidget() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppPadding.p24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.inputYourCredentials,
                style: AppTextStyle.title,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: AppPadding.p16, bottom: AppPadding.p16),
              child: InputText(
                title: AppStrings.email,
                controller: _mailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: _focusNodeEmail,
                onTap: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(_focusNodeEmail);
                  });
                },
                validator: (value) => ValidateOperations.emailValidation(value),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: AppPadding.p16),
              child: InputText(
                title: AppStrings.password,
                controller: _passController,
                isPass: true,
                focusNode: _focusNodePassword,
                onTap: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(_focusNodePassword);
                  });
                },
                validator: (value) =>
                    ValidateOperations.passwordValidation(value),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: AppPadding.p40),
              child: const Text(
                AppStrings.forgotPassword,
                style: TextStyle(color: ColorsGlobal.grey2),
              ),
            ),
            Button(
              label: AppStrings.login,
              width: AppSize.s328,
              height: AppSize.s62,
              colorBackgroud: ColorsGlobal.globalPink,
              colorLabel: ColorsGlobal.white,
              onPressed: () => loginEmail(),
            ),
            Button(
              label: AppStrings.createAccountInstead,
              colorLabel: ColorsGlobal.grey,
              colorBorder: ColorsGlobal.grey,
              colorBackgroud: ColorsGlobal.white,
              width: AppSize.s328,
              height: AppSize.s62,
              onPressed: () => signupEmail(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarScreen(
          title: AppStrings.loginEmail,
        ),
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationEmailInProgress) {
              const CircularProgressIndicator();
            } else if (state is AuthenticationEmailSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Login with Email success.'),
                  backgroundColor: ColorsGlobal.green));
              context.go(RouteName.getCurrentLocation);
            } else if (state is AuthenticationEmailFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login with email fail.')),
              );
            }
          },
          child: loginEmailWidget(),
        ));
  }
}
