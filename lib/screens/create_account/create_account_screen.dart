import 'package:flutter/material.dart';
import 'package:foodeck_app/routes/app_routes.dart';
import 'package:foodeck_app/screens/create_account/otp_screen.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/widgets/header.dart';
import 'package:foodeck_app/widgets/custom_login_button.dart';
import 'package:foodeck_app/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  //
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameController;
    emailController;
    phoneController;
    passwordController;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //
  void _loginInstead() {
    setState(() {
      Navigator.pushNamed(context, AppRoutes.loginScreen);
    });
  }

  //
  bool _obscureText = true;
  void _onTapObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //
  RegExp nameRegex = RegExp(r'^[^!@#$%^&+`;/_~*(),.?":{}|<>0-9]{5,}$');
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  bool _isValidateName = true;
  bool _isValidateEmail = true;
  bool _isValidatePhone = true;
  bool _isValidatePassword = true;

  void _checkValid() {
    setState(() {
      setState(() {
        _isValidateName = nameRegex.hasMatch(nameController.text);
        _isValidateEmail = emailRegex.hasMatch(emailController.text);
        _isValidatePhone = phoneController.text.length == 10 ? true : false;
        _isValidatePassword =
            passwordController.text.length >= 6 ? true : false;
      });
    });
  }

  //
  final supabase = Supabase.instance.client;
  Future<void> _createAnAccount() async {
    final emailUser = await Supabase.instance.client
        .from("user_account")
        .select("email")
        .eq("email", emailController.text);

    if (emailUser.isEmpty) {
      //create new user
      await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      //Navigation to OTP screen
      await Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTPScreen(
                      email: emailController.text.trim(),
                      name: nameController.text.trim(),
                      phone: phoneController.text.trim(),
                      password: passwordController.text.trim(),
                    )));
      });
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Email has been used. Try another one!',
            style: TextStyle(color: AppColor.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColor.primary,
        ));
      });
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: Header(headerTitle: "Create an account"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Divider(
              height: 24,
              color: Colors.transparent,
            ),
            Container(
              width: 328,
              alignment: Alignment.centerLeft,
              child: Text(
                "Input your credentials",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
              ),
            ),
            const Divider(
              height: 16,
              color: Colors.transparent,
            ),
            CustomTextFormField(
              controller: nameController,
              label: "Name",
              obscureText: false,
              errorText: _isValidateName == false ? "*Invalid name!" : "",
            ),
            CustomTextFormField(
              controller: emailController,
              label: "Email",
              obscureText: false,
              errorText: _isValidateEmail == false ? "*Invalid email!" : "",
            ),
            CustomTextFormField(
              controller: phoneController,
              label: "Phone No.",
              obscureText: false,
              errorText: _isValidatePhone == false
                  ? "*Phone No. only contains 10 number characters!"
                  : "",
            ),
            CustomTextFormField(
              controller: passwordController,
              onTapObscureText: _onTapObscureText,
              label: "Password",
              obscureText: true,
              errorText: _isValidatePassword == false
                  ? "*Password at least 6 characters!"
                  : "",
            ),
            const Divider(
              height: 40,
              color: Colors.transparent,
            ),
            CustomLoginButton(
              customLoginButtonsInfo: customLoginButtonsInfo[7],
              onPressed: () async {
                setState(() {
                  _checkValid();

                  _isValidateName &&
                          _isValidateEmail &&
                          _isValidatePhone &&
                          _isValidatePassword == true
                      ? _createAnAccount()
                      : null;
                });
              },
            ),
            const Divider(
              height: 16,
              color: Colors.transparent,
            ),
            CustomLoginButton(
              customLoginButtonsInfo: customLoginButtonsInfo[8],
              onPressed: _loginInstead,
            ),
          ],
        ),
      ),
    );
  }
}
