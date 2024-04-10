import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/credit_card_components/credit_card_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/utils/app_images.dart';
import 'package:google_fonts/google_fonts.dart';

class CreditCard extends StatelessWidget {
  final CreditCardInfo creditCardInfo;
  const CreditCard({super.key, required this.creditCardInfo});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          width: 328,
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(
                AppImage.creditCard,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: 40,
          child: Text(
            "****${creditCardInfo.cardNumber.substring(16)}",
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          bottom: 40,
          left: 40,
          child: Text(
            creditCardInfo.cardName,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
