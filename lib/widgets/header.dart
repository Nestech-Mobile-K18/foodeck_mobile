import 'package:flutter/material.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final dynamic onBack;
  final String headerTitle;

  //
  const Header({super.key, required this.headerTitle, this.onBack});

  @override
  Widget build(BuildContext context) {
    void onPressedBackButton() {
      Navigator.pop(context);
    }

//
    return AppBar(
      elevation: 0,
      leading: BackButton(
        color: AppColor.black,
        onPressed: onBack ?? onPressedBackButton,
      ),
      leadingWidth: 32,
      title: Text(
        headerTitle,
        style: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: AppColor.black,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 8),
        child: Container(
          height: 8,
          color: AppColor.grey6,
        ),
      ),
    );
  }
}
