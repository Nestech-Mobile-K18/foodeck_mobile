import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/cart_screen/cart/cart_item_info.dart';
import 'package:foodeck_app/screens/home_screen/home_screen.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/utils/app_images.dart';
import 'package:google_fonts/google_fonts.dart';

class PaySuccess extends StatefulWidget {
  const PaySuccess({super.key});

  @override
  State<PaySuccess> createState() => _PaySuccessState();
}

class _PaySuccessState extends State<PaySuccess> {
//
  void _clearItemCart() {
    cartItemInfo.clear();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 68,
            width: double.infinity,
          ),
          Image.asset(
            AppImage.paySuccess,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 148,
          ),
          ElevatedButton(
            onPressed: () {
              _clearItemCart();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen(page: 0)));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              padding: EdgeInsets.zero,
              fixedSize: const Size(328, 62),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
            child: Text(
              "Go Home",
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColor.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
