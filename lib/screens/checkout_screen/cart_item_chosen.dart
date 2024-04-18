import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/cart_screen/cart/cart_item_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemChosen extends StatelessWidget {
  final String price;
  final CartItemInfo cartItemInfo;
  const CartItemChosen(
      {super.key, required this.cartItemInfo, required this.price});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328,
      height: 54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${cartItemInfo.quantity}x ${cartItemInfo.name}",
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            price,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColor.grey1,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
