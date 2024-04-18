import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/cart_screen/cart/cart_item_info.dart';
import 'package:foodeck_app/screens/cart_screen/cart_screen.dart';
import 'package:foodeck_app/screens/checkout_screen/cart_item_chosen.dart';
import 'package:foodeck_app/screens/checkout_screen/credit_card.dart';
import 'package:foodeck_app/screens/food_menu_screen/deals_tab/deals_item_infomation.dart';
import 'package:foodeck_app/screens/pay_success/pay_success.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/add_credit_card_tab.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/credit_card_components/credit_card_info.dart';
import 'package:foodeck_app/screens/profile_screen/profile_info.dart';
import 'package:foodeck_app/screens/profile_screen/your_locations/my_locations_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/utils/app_images.dart';
import 'package:foodeck_app/widgets/custom_text_form_field.dart';
import 'package:foodeck_app/widgets/header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CheckOutScreen extends StatefulWidget {
  final String subtotal;
  final String deliverfee;
  final String vat;
  final String coupon;
  final String detailCoupon;
  final String total;
  final String extra;
  final String dish;
  final String size;
  final String quantity;

  const CheckOutScreen({
    super.key,
    required this.subtotal,
    required this.deliverfee,
    required this.vat,
    required this.coupon,
    required this.total,
    required this.detailCoupon,
    required this.extra,
    required this.dish,
    required this.size,
    required this.quantity,
  });

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  //
  TextEditingController intructionController = TextEditingController();
  //
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();

  @override
  void initState() {
    super.initState();
    intructionController;
    cardNameController;
    cardNumberController;
    expiryDateController;
    cvcController;
  }

  @override
  void dispose() {
    intructionController.dispose();
    cardNameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvcController.dispose();
    super.dispose();
  }

  //

  //show dialog when add new card
  void _showDialog() {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) => Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Dialog(
            alignment: Alignment.center,
            child: AddCreditCardTab(
              cardNameController: cardNameController,
              cardNumberController: cardNumberController,
              expiryDateController: expiryDateController,
              cvcController: cvcController,
              addCard: () {
                setState(() {
                  _addCreditCard();
                  _updateCardOnSupabase();
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  //
  void _addCreditCard() {
    //
    final newCreditCard = CreditCardInfo(
      id: DateTime.now().toString(),
      isSelected: false,
      cardNumber: cardNumberController.text,
      cardName: cardNameController.text,
      cardExpiryDate: expiryDateController.text,
      cardCVC: cvcController.text,
    );

    setState(() {
      creditCardInfo.add(newCreditCard);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckOutScreen(
            subtotal: widget.subtotal,
            deliverfee: widget.deliverfee,
            vat: widget.vat,
            coupon: widget.coupon,
            total: widget.total,
            detailCoupon: widget.detailCoupon,
            extra: widget.extra,
            dish: widget.dish,
            size: widget.size,
            quantity: widget.quantity,
          ),
        ),
      );
    });
  }

  //update data credit card on supabase
  final supabase = Supabase.instance.client;
  Future<void> _updateCardOnSupabase() async {
    final userInfo = await supabase
        .from("user_account")
        .select("id")
        .filter(
          "email",
          "eq",
          profileInfo[0].email.toString(),
        )
        .single();
    final userID = userInfo.entries.single.value;
    //
    await supabase.from("credit_card").insert({
      "card_name": cardNameController.text,
      "card_number": cardNumberController.text,
      "card_expiry_date": expiryDateController.text,
      "card_cvc": cvcController.text,
      "user_id": userID,
    });
  }

  //
  void _checkCard() {
    //notification when there is no card for paying
    creditCardInfo.isEmpty
        ? showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              alignment: Alignment.center,
              child: Container(
                height: 100,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColor.white,
                ),
                child: Text(
                  "Please add a card for payment!",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ),
          ).timeout(
            const Duration(seconds: 2),
            onTimeout: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          )

        // notification choose a card before continuing paying
        : creditCardInfo
                    .map((creditCardInfo) => creditCardInfo.isSelected)
                    .contains(true) ==
                false
            ? showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  alignment: Alignment.center,
                  child: Container(
                    height: 100,
                    width: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColor.white,
                    ),
                    child: Text(
                      "Please choose a card for payment!",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                ),
              ).timeout(
                const Duration(seconds: 2),
                onTimeout: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              )
            : null;
  }
  //update data user's ordering on supabase

  Future<void> _updateUserOrderingOnSupabase() async {
    final userInfo = await supabase
        .from("user_account")
        .select("id")
        .filter(
          "email",
          "eq",
          profileInfo[0].email.toString(),
        )
        .single();
    final userID = userInfo.entries.single.value;

    //
    await supabase.from("user_ordering").insert({
      "created_at": DateTime.now().toString(),
      "store": dealsItemInfomation.first.store.toString(),
      "location": dealsItemInfomation.first.location.toString(),
      "dish": widget.dish.toString(),
      "size": widget.size.toString(),
      "quantity": widget.quantity.toString(),
      "extra": widget.extra.toString(),
      "drinks": "",
      "coupon_code": widget.detailCoupon.toString(),
      "delivery_fee": widget.deliverfee.toString(),
      "VAT": widget.vat.toString(),
      "coupon_price": widget.coupon.toString(),
      "subtotal_price": widget.subtotal.toString(),
      "total_price": widget.total.toString(),
      "user_location": myLocations.last.location.toString(),
      "card_number": creditCardInfo[creditCardInfo.indexWhere(
              (creditCardInfo) => creditCardInfo.isSelected == true)]
          .cardNumber
          .toString(),
      "delivery_intruction": "",
      "dish_intructions": "",
      "not_available_intruction": "",
      "user_id": userID,
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: Header(
          headerTitle: "Checkout",
          onBack: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CartScreen()));
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
              width: 328,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Delivery Address",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColor.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          myLocations.isEmpty
                              ? "Add your location for shipping"
                              : myLocations[0].location,
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: AppColor.grey1,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.edit_outlined,
                      size: 22,
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 160,
              width: 328,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(AppImage.myLocation),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              height: 8,
              color: AppColor.grey6,
            ),
            const SizedBox(
              height: 15,
              width: double.infinity,
            ),
            SizedBox(
              width: 328,
              child: Text(
                "Delivery Instructions",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColor.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 328,
              child: Text(
                "Let us know if you have specific things in mind",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: AppColor.grey1,
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
              controller: intructionController,
              obscureText: false,
              errorText: "",
              hintText: "e.g. I am home around 10 pm",
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              height: 8,
              color: AppColor.grey6,
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: 328,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment Method",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showDialog();
                      });
                    },
                    child: Icon(
                      Icons.add,
                      size: 22,
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.zero,
              margin: creditCardInfo.length == 1
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(horizontal: 25),
              width: creditCardInfo.length == 1 ? 348 : double.infinity,
              height: 200,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: creditCardInfo.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: ((context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          for (var element in creditCardInfo) {
                            element.isSelected = false;
                          }
                          creditCardInfo[index].isSelected = true;
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CreditCard(
                            creditCardInfo: creditCardInfo[index],
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.zero,
                            height: 60,
                            width: 60,
                            child: creditCardInfo[index].isSelected == true
                                ? Icon(
                                    Icons.check_sharp,
                                    color: AppColor.green,
                                    size: 50,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              height: 8,
              color: AppColor.grey6,
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: 328,
              child: Text(
                "Order Summary",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColor.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 328,
              height: cartItemInfo.length.toDouble() * 54,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: cartItemInfo.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => CartItemChosen(
                    cartItemInfo: cartItemInfo[index],
                    price: "\$${cartItemInfo[index].price}"),
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
                    "Subtotal",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    widget.subtotal,
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
                    "Delivery Fee",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    widget.deliverfee,
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
                    widget.vat,
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
                    widget.coupon,
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
                    widget.total,
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _checkCard();

                        _updateUserOrderingOnSupabase();

                        creditCardInfo
                                    .map((creditCardInfo) =>
                                        creditCardInfo.isSelected)
                                    .contains(true) ==
                                true
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PaySuccess()))
                            : null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      padding: EdgeInsets.zero,
                      fixedSize: const Size(117, 54),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                    child: Text(
                      "Pay now",
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
