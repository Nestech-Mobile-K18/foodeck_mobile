import 'package:flutter/material.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/utils/app_icons.dart';
import 'package:google_fonts/google_fonts.dart';

///
class CustomLoginButtonInfo {
  Widget icon;
  final String label;
  final Color colorText;
  final Color colorButton;
  final Color colorBorder;

  CustomLoginButtonInfo({
    required this.icon,
    required this.label,
    required this.colorText,
    required this.colorButton,
    required this.colorBorder,
  });
}

List<CustomLoginButtonInfo> customLoginButtonsInfo = [
  CustomLoginButtonInfo(
    icon: Image.asset(AppIcon.googleLogo),
    label: "Login via Google",
    colorText: AppColor.white,
    colorButton: AppColor.red,
    colorBorder: Colors.transparent,
  ),
  CustomLoginButtonInfo(
    icon: Image.asset(AppIcon.facebookLogo),
    label: "Login via Facebook",
    colorText: AppColor.white,
    colorButton: AppColor.blue,
    colorBorder: Colors.transparent,
  ),
  CustomLoginButtonInfo(
    icon: Image.asset(AppIcon.appleLogo),
    label: "Login via Apple",
    colorText: AppColor.white,
    colorButton: AppColor.black,
    colorBorder: Colors.transparent,
  ),
  CustomLoginButtonInfo(
    icon: Image.asset(AppIcon.googleLogo),
    label: "Login via Email",
    colorText: AppColor.white,
    colorButton: AppColor.primary,
    colorBorder: Colors.transparent,
  ),
  CustomLoginButtonInfo(
    icon: const SizedBox(),
    label: "Create an account",
    colorText: AppColor.grey1,
    colorButton: AppColor.white,
    colorBorder: AppColor.grey1,
  ),
  CustomLoginButtonInfo(
    icon: const SizedBox(),
    label: "Login",
    colorText: AppColor.white,
    colorButton: AppColor.primary,
    colorBorder: Colors.transparent,
  ),
  CustomLoginButtonInfo(
    icon: const SizedBox(),
    label: "Create an account instead",
    colorText: AppColor.grey1,
    colorButton: AppColor.white,
    colorBorder: AppColor.grey1,
  ),
  CustomLoginButtonInfo(
    icon: const SizedBox(),
    label: "Create an account",
    colorText: AppColor.white,
    colorButton: AppColor.primary,
    colorBorder: Colors.transparent,
  ),
  CustomLoginButtonInfo(
    icon: const SizedBox(),
    label: "Login instead",
    colorText: AppColor.grey1,
    colorButton: AppColor.white,
    colorBorder: AppColor.grey1,
  ),
  CustomLoginButtonInfo(
    icon: const SizedBox(),
    label: "Confirm",
    colorText: AppColor.white,
    colorButton: AppColor.primary,
    colorBorder: Colors.transparent,
  ),
  CustomLoginButtonInfo(
    icon: const SizedBox(),
    label: "Reset",
    colorText: AppColor.white,
    colorButton: AppColor.primary,
    colorBorder: Colors.transparent,
  ),
];

///
class CustomLoginButton extends StatelessWidget {
  final dynamic onPressed;
  final CustomLoginButtonInfo customLoginButtonsInfo;
  const CustomLoginButton({
    super.key,
    required this.customLoginButtonsInfo,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: customLoginButtonsInfo.colorButton,
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        side: BorderSide(
          width: 1,
          color: customLoginButtonsInfo.colorBorder,
        ),
        fixedSize: const Size(328, 62),
      ),
      icon: customLoginButtonsInfo.icon,
      label: Text(
        customLoginButtonsInfo.label,
        style: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: customLoginButtonsInfo.colorText,
        ),
      ),
    );
  }
}
