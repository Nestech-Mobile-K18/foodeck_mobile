import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodeck_app/routes/app_routes.dart';
import 'package:foodeck_app/screens/profile_screen/profile_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/widgets/appbar.dart';
import 'package:foodeck_app/widgets/custom_login_button.dart';
import 'package:foodeck_app/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViaEmailScreen extends StatefulWidget {
  const LoginViaEmailScreen({super.key});

  @override
  State<LoginViaEmailScreen> createState() => _LoginViaEmailScreenState();
}

class _LoginViaEmailScreenState extends State<LoginViaEmailScreen> {
  //
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    emailController;
    passwordController;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //
  bool _obscureText = true;
  void _onTapObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  //

  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  bool _isValidateEmail = true;
  bool _isValidatePassword = true;
  //
  final supabase = Supabase.instance.client;
//
  Future<void> _login() async {
    final emailUser = await Supabase.instance.client
        .from("user_account")
        .select("email")
        .eq("email", emailController.text);
    final passwordUser = await Supabase.instance.client
        .from("user_account")
        .select("email")
        .eq("password", passwordController.text)
        .match({"password": passwordController.text});

    if (emailUser.isNotEmpty && passwordUser.isNotEmpty) {
      final AuthResponse res =
          await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // final data = await Supabase.instance.client.from('users').select('name');
      if (res.user != null) {
        //   Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => HomeScreen(name: data.toString()),
        //   ),
        // );
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "You're signed in!",
              style: TextStyle(color: AppColor.white),
              textAlign: TextAlign.center,
            ),
            backgroundColor: AppColor.primary,
          ));
        });

        await Future.delayed(
          const Duration(seconds: 5),
          () {
            Navigator.pushNamed(context, AppRoutes.homeScreen);
          },
        );
      }
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Wrong Email or Password",
            style: TextStyle(color: AppColor.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColor.primary,
        ));
      });
    }
  }

  String name = "";
  Future<void> _getinfoUser() async {
    final nameUser = await Supabase.instance.client
        .from("user_account")
        .select("email")
        .eq("email", emailController.text)
        .select("name");
    final emailUser = await Supabase.instance.client
        .from("user_account")
        .select("email")
        .eq("email", emailController.text)
        .select("email");
    final phoneUser = await Supabase.instance.client
        .from("user_account")
        .select("email")
        .eq("email", emailController.text)
        .select("phone");
    final passwordUser = await Supabase.instance.client
        .from("user_account")
        .select("email")
        .eq("email", emailController.text)
        .select("password");

//update profile info when signed in
    final updateProfile = ProfileInfo(
      name: nameUser.single.values.single.toString(),
      email: emailUser.single.values.single.toString(),
      phone: phoneUser.single.values.single.toString(),
      password: passwordUser.single.values.single.toString(),
    );

    profileInfo.clear();
    profileInfo.add(updateProfile);
  }

  //
  void _checkValid() {
    setState(() {
      _isValidateEmail = emailRegex.hasMatch(emailController.text);
      _isValidatePassword = passwordController.text.length >= 6 ? true : false;
    });
  }

  //
  void _createAnAccountInstead() {
    setState(() {
      Navigator.pushNamed(context, AppRoutes.createAccount);
    });
  }

  //
  void _forgotPassword() {
    setState(() {
      Navigator.pushNamed(context, AppRoutes.forgotPassword);
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: Header(headerTitle: "Login via Email"),
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
              controller: emailController,
              label: "Email",
              obscureText: false,
              errorText: _isValidateEmail == false ? "*Invalid email!" : "",
            ),
            CustomTextFormField(
              controller: passwordController,
              onTapObscureText: _onTapObscureText,
              label: "Password",
              obscureText: _obscureText,
              errorText: _isValidatePassword == false
                  ? "*Password at least 6 characters!"
                  : "",
            ),
            InkWell(
              onTap: _forgotPassword,
              child: Container(
                width: 328,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey1,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 40,
              color: Colors.transparent,
            ),
            CustomLoginButton(
              customLoginButtonsInfo: customLoginButtonsInfo[5],
              onPressed: () {
                _checkValid();

                _isValidateEmail && _isValidatePassword == true
                    ? _login()
                    : null;
                _getinfoUser();
              },
            ),
            const Divider(
              height: 16,
              color: Colors.transparent,
            ),
            CustomLoginButton(
              customLoginButtonsInfo: customLoginButtonsInfo[6],
              onPressed: _createAnAccountInstead,
            ),
          ],
        ),
      ),
    );
  }
}
