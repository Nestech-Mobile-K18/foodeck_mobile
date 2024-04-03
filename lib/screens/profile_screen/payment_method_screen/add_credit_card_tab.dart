import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/credit_card_components/credit_card_info.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/payment_method_screen.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/utils/app_images.dart';
import 'package:foodeck_app/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCreditCardTab extends StatefulWidget {
  const AddCreditCardTab({super.key});

  @override
  State<AddCreditCardTab> createState() => _AddCreditCardTabState();
}

class _AddCreditCardTabState extends State<AddCreditCardTab> {
  //
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
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
  List<TextInputFormatter> formatterNumberCard = [
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
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(16),
  ];
  List<TextInputFormatter> formatterCCV = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(3),
  ];
  List<TextInputFormatter> formatterExipryDate = [
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
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(4),
  ];
  //
  void _addCreditCard() {
    final newCreditCard = CreditCardInfo(
      id: DateTime.now().toString(),
      cardNumber: cardNumberController.text,
      cardName: cardNameController.text,
      cardExpiryDate: expiryDateController.text,
      cardCVC: cvcController.text,
    );
    setState(() {
      creditCardInfo.add(newCreditCard);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PaymentMethodScreen()));
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 610,
      width: 350,
      decoration: BoxDecoration(
        color: AppColor.grey5,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 200 * 0.8,
                width: 328 * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImage.creditCard),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40 * 0.8,
                right: 40 * 0.8,
                child: Text(
                  "Card Number",
                  style: GoogleFonts.inter(
                    fontSize: 22 * 0.8,
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                bottom: 40 * 0.8,
                left: 40 * 0.8,
                child: Text(
                  "Card Info",
                  style: GoogleFonts.inter(
                    fontSize: 22 * 0.8,
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: double.infinity,
            height: 24 * 0.8,
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
          ElevatedButton(
            onPressed: _addCreditCard,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              fixedSize: const Size(150, 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Add card",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColor.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
