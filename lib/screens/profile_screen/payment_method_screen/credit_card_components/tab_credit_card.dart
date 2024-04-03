import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/credit_card_components/credit_card_info.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/payment_method_screen.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/utils/app_images.dart';
import 'package:foodeck_app/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class TabCreditCard extends StatefulWidget {
  final CreditCardInfo creditCardInfo;
  const TabCreditCard({super.key, required this.creditCardInfo});

  @override
  State<TabCreditCard> createState() => _TabCreditCardState();
}

class _TabCreditCardState extends State<TabCreditCard> {
  //
  late TextEditingController cardNameController =
      TextEditingController(text: widget.creditCardInfo.cardName);
  late TextEditingController cardNumberController =
      TextEditingController(text: widget.creditCardInfo.cardNumber);
  late TextEditingController expiryDateController =
      TextEditingController(text: widget.creditCardInfo.cardExpiryDate);
  late TextEditingController cvcController =
      TextEditingController(text: widget.creditCardInfo.cardCVC);
  @override
  void initState() {
    super.initState();
    cardNameController;
    cardNumberController;
    expiryDateController;
    cvcController;
  }

  @override
  void dispose() {
    cardNameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvcController.dispose();
    super.dispose();
  }

  //
  void _removeCreditCard() {
    setState(() {
      creditCardInfo.removeWhere(
          (creditCardInfo) => widget.creditCardInfo.id == creditCardInfo.id);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PaymentMethodScreen()));
    });
    print(cardNumberController.text);
    print(widget.creditCardInfo.cardNumber);
  }

  //
  void _updateCreditCard() {
    creditCardInfo[creditCardInfo.indexWhere((creditCardInfo) =>
            widget.creditCardInfo.id == creditCardInfo.id)] =
        CreditCardInfo(
            id: widget.creditCardInfo.id,
            cardName: cardNameController.text,
            cardNumber: cardNumberController.text,
            cardExpiryDate: expiryDateController.text,
            cardCVC: cvcController.text);
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PaymentMethodScreen()));
    });
    print(cardNumberController.text);
    print(widget.creditCardInfo.cardNumber);
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      width: 328,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
            height: 24,
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 200,
                width: 328,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImage.creditCard),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 40,
                child: Text(
                  widget.creditCardInfo.cardNumber,
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
                  widget.creditCardInfo.cardName,
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextFormField(
            controller: cardNameController,
            label: "Card name",
            obscureText: false,
            errorText: '',
          ),
          CustomTextFormField(
            controller: cardNumberController,
            label: "Card number",
            obscureText: false,
            errorText: '',
          ),
          CustomTextFormField(
            controller: expiryDateController,
            label: "Expiry date",
            obscureText: false,
            errorText: '',
          ),
          CustomTextFormField(
            controller: cvcController,
            label: "CVC",
            obscureText: false,
            errorText: '',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _updateCreditCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  fixedSize: const Size(150, 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Update info",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _removeCreditCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.grey1,
                  fixedSize: const Size(150, 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Remove card",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
