import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  //
  List<TextInputFormatter> formatterNumberCard = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(16),
    TextInputFormatter.withFunction(
      (oldValue, newValue) {
        if (newValue.selection.baseOffset == 0) {
          return newValue;
        }
        String inputData = newValue.text;
        StringBuffer buffer = StringBuffer();

        for (var i = 0; i < inputData.length; i++) {
          buffer.write(inputData[i]);
          int index = i + 1;

          if (index % 4 == 0 && inputData.length != index) {
            buffer.write("  ");
          }
        }
        return TextEditingValue(
          text: buffer.toString(),
          selection: TextSelection.collapsed(
            offset: buffer.toString().length,
          ),
        );
      },
    ),
  ];
  List<TextInputFormatter> formatterCCV = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(3),
  ];
  List<TextInputFormatter> formatterExipryDate = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(4),
    TextInputFormatter.withFunction(
      (oldValue, newValue) {
        var newText = newValue.text;
        if (newValue.selection.baseOffset == 0) {
          return newValue;
        }
        var buffer = StringBuffer();
        for (int i = 0; i < newText.length; i++) {
          buffer.write(newText[i]);
          var nonZeroIndex = i + 1;
          if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
            buffer.write('/');
          }
        }
        var string = buffer.toString();
        return newValue.copyWith(
            text: string,
            selection: TextSelection.collapsed(offset: string.length));
      },
    ),
  ];
  //

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
                  "****${widget.creditCardInfo.cardNumber.substring(16)}",
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
            onChanged: (value) {
              setState(() {
                cardNameController.value = cardNameController.value.copyWith(
                    text: value,
                    selection: TextSelection.collapsed(offset: value.length),
                    composing: TextRange.empty);
              });
            },
          ),
          CustomTextFormField(
              controller: cardNumberController,
              label: "Card number",
              obscureText: false,
              errorText: '',
              textInputFormatter: formatterNumberCard,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                setState(() {
                  cardNumberController.value = cardNumberController.value
                      .copyWith(
                          text: text,
                          selection:
                              TextSelection.collapsed(offset: text.length),
                          composing: TextRange.empty);
                });
              }),
          CustomTextFormField(
            controller: expiryDateController,
            label: "Expiry date",
            obscureText: false,
            errorText: '',
            textInputFormatter: formatterExipryDate,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
              setState(() {
                expiryDateController.value = expiryDateController.value
                    .copyWith(
                        text: text,
                        selection: TextSelection.collapsed(offset: text.length),
                        composing: TextRange.empty);
              });
            },
          ),
          CustomTextFormField(
            controller: cvcController,
            label: "CVC",
            obscureText: false,
            errorText: '',
            textInputFormatter: formatterCCV,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                int length = value.length;
                if (length == 4 || length == 9 || length == 14) {
                  cardNumberController.text = '$value ';
                  cardNumberController.selection = TextSelection.fromPosition(
                      TextPosition(offset: value.toString().length + 1));
                }
              });
            },
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
