import 'package:flutter/material.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  const CustomSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      height: 54,
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.white,
      ),
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: AppColor.black,
        ),
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search_outlined,
              size: 24,
            ),
            prefixIconColor: AppColor.grey1,
            hintText: "Search",
            hintStyle: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColor.grey2,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
