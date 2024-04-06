import 'package:flutter/material.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/widgets/header.dart';
import 'package:foodeck_app/widgets/custom_login_button.dart';
import 'package:foodeck_app/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  //
  final TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    emailController;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  //

  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  bool _isValidateEmail = true;
  //

  void _checkValid() {
    setState(() {
      _isValidateEmail = emailRegex.hasMatch(emailController.text);
    });
  }

  //
  final supabase = Supabase.instance.client;
  Future<void> _reset() async {}

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: Header(headerTitle: "Forgot Password"),
      ),
      body: Column(
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
            controller: emailController,
            label: "Email",
            obscureText: false,
            errorText: _isValidateEmail == false ? "*Invalid email!" : "",
          ),
          const Divider(
            height: 40,
            color: Colors.transparent,
          ),
          CustomLoginButton(
            customLoginButtonsInfo: customLoginButtonsInfo[10],
            onPressed: () {
              setState(() {
                _checkValid();

                _isValidateEmail == true ? _reset() : null;
              });
            },
          )
        ],
      ),
    );
  }
}
