import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/cart_screen/cart/cart_card.dart';
import 'package:foodeck_app/screens/cart_screen/cart/cart_item_info.dart';
import 'package:foodeck_app/screens/cart_screen/coupon/coupon.dart';
import 'package:foodeck_app/screens/cart_screen/drinks/list_drinks.dart';
import 'package:foodeck_app/screens/home_screen/home_screen.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/widgets/custom_text_form_field.dart';
import 'package:foodeck_app/widgets/header.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  final CartItemInfo? cartItemInfo;
  final Coupon? coupon;
  const CartScreen({super.key, this.coupon, this.cartItemInfo});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  //

  TextEditingController couponController = TextEditingController();
  @override
  void initState() {
    couponController;
    super.initState();
  }

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  //

  //
  double subtotal = 0;
  double deliveryFee = 10;
  double vat = 4;
  double valueCoupon = 0;

  void _checkCoupon() {
    setState(() {
      (coupon.map((coupon) => coupon.code).contains(couponController.text)) ==
              false
          ? errorText = "*Invalid coupon, try another one!"
          : errorText = "";
      //
      (coupon.map((coupon) => coupon.code).contains(couponController.text)) ==
              true
          ? valueCoupon = coupon[coupon.indexWhere(
                  (coupon) => coupon.code.contains(couponController.text))]
              .discount
          : valueCoupon = 0;
      //
    });
  }

  //
  String errorText = "";
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: Header(
          headerTitle: "Cart",
          onBack: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeScreen(page: 0)));
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
              width: double.infinity,
            ),
            SizedBox(
              width: double.infinity,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: cartItemInfo.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => CartCard(
                  cartItemInfo: cartItemInfo[index],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 30),
              width: double.infinity,
              color: AppColor.grey6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 328,
                    height: 24,
                  ),
                  SizedBox(
                    width: 368,
                    child: Text(
                      "Popular with these",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: AppColor.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const ListDrinks(),
                ],
              ),
            ),
            SizedBox(
              width: 328,
              child: Text(
                "Coupon",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColor.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              width: 328,
              height: 54,
              border: Border.all(
                width: 1,
                color: AppColor.grey6,
              ),
              onFieldSubmitted: (value) {
                setState(() {
                  couponController.text == ""
                      ? errorText = ""
                      : errorText = errorText;
                });
              },
              controller: couponController,
              obscureText: false,
              errorText: errorText,
              suffixIcon: InkWell(
                onTap: _checkCoupon,
                child: Icon(
                  Icons.arrow_forward,
                  size: 22,
                  color: AppColor.black,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              height: 8,
              color: AppColor.grey6,
            ),
            const SizedBox(
              width: double.infinity,
              height: 24,
            ),
            SizedBox(
              width: 328,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Subtotal",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "\$${(cartItemInfo.fold(0, (previousValue, element) => (previousValue + element.price))).toString()}",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primary,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 328,
              height: 54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Fee",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "\$${deliveryFee.round()}",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.grey1,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              height: 1,
              color: AppColor.grey6,
            ),
            SizedBox(
              width: 328,
              height: 54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "VAT",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "\$${vat.round()}",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.grey1,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              height: 1,
              color: AppColor.grey6,
            ),
            SizedBox(
              width: 328,
              height: 54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coupon",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    valueCoupon == 0 || valueCoupon > 1
                        ? "-\$${valueCoupon.round()}"
                        : "-${(valueCoupon * 100).round()}%",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.green,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              height: 1,
              color: AppColor.grey6,
            ),
            const SizedBox(
              height: 64,
            ),
            SizedBox(
              width: 328,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    valueCoupon == 0
                        ? "\$${(cartItemInfo.fold(0, (previousValue, element) => (previousValue + element.price)) + deliveryFee + vat).toStringAsFixed(2)}"
                        : valueCoupon < 1
                            ? "\$${(((cartItemInfo.fold(0, (previousValue, element) => (previousValue + element.price)) + deliveryFee + vat) * valueCoupon)).toStringAsFixed(2)}"
                            : valueCoupon >= 1
                                ? "\$${(cartItemInfo.fold(0, (previousValue, element) => (previousValue + element.price)) + deliveryFee + vat + valueCoupon).toString()}"
                                : "",
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      padding: EdgeInsets.zero,
                      fixedSize: const Size(172, 54),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                    child: Text(
                      "Go to Checkout",
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
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
