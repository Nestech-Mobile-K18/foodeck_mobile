import 'package:flutter/material.dart';
import 'package:foodeck_app/routes/app_routes.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/widgets/header.dart';
import 'package:foodeck_app/widgets/custom_login_button.dart';
import 'package:foodeck_app/widgets/custom_otp_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:foodeck_app/screens/profile_screen/profile_info.dart';

class OTPScreen extends StatefulWidget {
  final String name;

  final String phone;
  final String password;
  final String email;
  const OTPScreen(
      {super.key,
      required this.email,
      required this.name,
      required this.phone,
      required this.password});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  //
  final TextEditingController otp1Controller = TextEditingController();
  final TextEditingController otp2Controller = TextEditingController();
  final TextEditingController otp3Controller = TextEditingController();
  final TextEditingController otp4Controller = TextEditingController();
  final TextEditingController otp5Controller = TextEditingController();
  final TextEditingController otp6Controller = TextEditingController();
  //
  @override
  void initState() {
    super.initState();
    otp1Controller;
    otp2Controller;
    otp3Controller;
    otp4Controller;
    otp5Controller;
    otp6Controller;
  }

  @override
  void dispose() {
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();
    otp5Controller.dispose();
    otp6Controller.dispose();
    super.dispose();
  }

  //
  final supabase = Supabase.instance.client;
  Future<void> _confirm() async {
    String otpValue = otp1Controller.text +
        otp2Controller.text +
        otp3Controller.text +
        otp4Controller.text +
        otp5Controller.text +
        otp6Controller.text;
    try {
      await supabase.auth.verifyOTP(
        email: widget.email.toString(),
        token: otpValue.toString(),
        type: OtpType.email,
      );
      //Notification if success
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Please sign in to continue!',
              style: TextStyle(color: AppColor.white),
              textAlign: TextAlign.center,
            ),
            backgroundColor: AppColor.primary));
      });

      //Navigation to Homepage when success
      await Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushNamed(context, AppRoutes.loginScreen);
      });
      //update user account info on supabase
      await supabase.from('user_account').insert({
        "name": widget.name.toString().trim(),
        "email": widget.email.toString().trim(),
        "phone": widget.phone.toString().trim(),
        "password": widget.password.toString().trim(),
        "provider": "Email",
      });

      //Create local profile info
      final newProfile = ProfileInfo(
        name: widget.name.toString(),
        email: widget.email.toString().trim(),
        phone: widget.phone.toString().trim(),
      );

      profileInfo.clear();
      profileInfo.add(newProfile);
    } on AuthException catch (error) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message)));
      });
    } catch (error) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Invalid OTP!',
              style: TextStyle(color: AppColor.white),
              textAlign: TextAlign.center,
            ),
            backgroundColor: AppColor.primary));
      });
    }
  }

  //
  void _resend() async {}

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: Header(headerTitle: "OTP"),
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
              "Confirm the code we sent you",
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
          SizedBox(
            width: 328,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OTPField(
                    first: true, last: false, otpController: otp1Controller),
                OTPField(
                    first: false, last: false, otpController: otp2Controller),
                OTPField(
                    first: false, last: false, otpController: otp3Controller),
                OTPField(
                    first: false, last: false, otpController: otp4Controller),
                OTPField(
                    first: false, last: false, otpController: otp5Controller),
                OTPField(
                    first: false, last: true, otpController: otp6Controller),
              ],
            ),
          ),
          const Divider(
            height: 16,
            color: Colors.transparent,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _resend();
              });
            },
            child: Container(
              width: 328,
              alignment: Alignment.centerLeft,
              child: Text(
                "Resend",
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
            customLoginButtonsInfo: customLoginButtonsInfo[9],
            onPressed: _confirm,
          ),
        ],
      ),
    );
  }
}
