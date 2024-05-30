import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/pages/payment/models/payment.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_textfield.dart';
import 'package:template/widgets/method_button.dart';
import '../../../widgets/cross_bar.dart';
import '../../../widgets/custom_text.dart';
import '../vm/payment_view_model.dart';

class PaymentInputView extends StatefulWidget {
  const PaymentInputView({super.key});

  @override
  State<PaymentInputView> createState() => _PaymentInputViewState();
}

class _PaymentInputViewState extends State<PaymentInputView> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();
  final PaymentViewModel _viewModel = PaymentViewModel();
  Validation _validation = Validation();
  Icon? _expiryDateValidityIcon;

  bool isVisaCard = false;
  bool isMasterCard = false;

  @override
  void initState() {
    super.initState();

    // Add a listener to the card number text field to check the card type
    cardNumberController.addListener(checkCardType);
    // Add a listener to the expiry date text field to check validity
    expiryDateController.addListener(checkExpiryDateValidity);
    cardNameController.addListener(() {
      _validation.isNameValid(cardNameController.text);
    });
  }

  void checkCardType() {
    setState(() {
      // Get the card number after removing spaces
      final cardNumber =
          cardNumberController.text.replaceAll(RegExp(r'\s'), '');

      // Use intermediate variable to check tag type
      // Visa card starts with 4
      isVisaCard = RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$').hasMatch(cardNumber);
      // MasterCard starts with 5 or 2 and the second digit is between 1 and 5
      isMasterCard = RegExp(r'^(5[1-5]|2[0-9])[0-9]{14}$').hasMatch(cardNumber);
    });
  }

  String formatCardNumber(String input) {
    // Remove all non-numeric characters
    input = input.replaceAll(RegExp(r'\D'), '');
    // Insert a space every 4 characters
    final formattedValue = input.replaceAllMapped(
      RegExp(r'.{4}'),
      (match) => '${match.group(0)} ',
    );
    return formattedValue.trim(); // Trim to remove leading/trailing spaces
  }

  bool isExpiryDateValid(String expiryDate) {
    // Check if the expiration date is valid
    final now = DateTime.now();
    final parts = expiryDate.split('/');
    if (parts.length != 2) return false;

    // Get month and year from expiration date string
    final month = int.tryParse(parts[0]);
    final yearPrefix = int.tryParse(parts[1]);

    // Check if month and year are valid
    if (month == null || yearPrefix == null) return false;
    final year = 2000 + yearPrefix; // Convert yearPrefix to full year
    if (year < now.year || (year == now.year && month < now.month)) {
      // Expiry date has passed
      return false;
    }
    return true;
  }

  void checkExpiryDateValidity() {
    final value = expiryDateController.text;
    final isValid = isExpiryDateValid(value);

    // Display the icon corresponding to the validity of the expiration date
    setState(() {
      if (isValid) {
        // Display the blue tick icon
        _expiryDateValidityIcon = const Icon(Icons.check, color: Colors.green);
      } else {
        // Display the red X icon
        _expiryDateValidityIcon = const Icon(Icons.close, color: Colors.red);
      }
    });
  }

  String getPaymentMethod() {
    if (isVisaCard) return 'Visa';
    if (isMasterCard) return 'MasterCard';
    return 'Unknown';
  }

  @override
  void dispose() {
    super.dispose();
    cardNumberController.removeListener(checkCardType);
    cardNumberController.dispose();
    expiryDateController.removeListener(checkExpiryDateValidity);
    expiryDateController.dispose();
    cvcController.dispose();
    cardNameController.removeListener(() {
      _validation.isNameValid(cardNameController.text);
    });
    cardNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          title: StringExtensions.paymentMethod,
          color: ColorsGlobal.globalBlack,
          size: 17,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsGlobal.globalBlack,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CrossBar(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  CustomTextField(
                    controller: cardNumberController,
                    title: StringExtensions.cardNumber,
                    textInputType: TextInputType.number,
                    onChanged: (value) {
                      final formattedValue = formatCardNumber(value);
                      if (formattedValue != cardNumberController.text) {
                        cardNumberController.value =
                            cardNumberController.value.copyWith(
                          text: formattedValue,
                          selection: TextSelection.collapsed(
                              offset: formattedValue.length),
                        );
                      }
                    },
                    onEditingComplete: () {
                      final formattedValue =
                          formatCardNumber(cardNumberController.text);
                      if (formattedValue != cardNumberController.text) {
                        cardNumberController.value =
                            cardNumberController.value.copyWith(
                          text: formattedValue,
                          selection: TextSelection.collapsed(
                              offset: formattedValue.length),
                        );
                      }
                    },
                    iconSuffit: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isVisaCard)
                          Image.asset(
                            MediaRes.visaCard,
                            fit: BoxFit.cover,
                            width: 40,
                            height: 30,
                          ),
                        if (isMasterCard)
                          Image.asset(
                            MediaRes.masterCard,
                            fit: BoxFit.cover,
                            width: 40,
                            height: 30,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    iconSuffit: _expiryDateValidityIcon ?? SizedBox(),
                    controller: expiryDateController,
                    title: StringExtensions.expiryDate,
                    textInputType: TextInputType.datetime,
                    onChanged: (value) {
                      checkExpiryDateValidity();
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: cvcController,
                    title: StringExtensions.cvc,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}$')),
                      // Only allow numbers and up to 3 characters
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: cardNameController,
                    title: StringExtensions.cardName,
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(height: 20),
                  MethodButton(
                    color: ColorsGlobal.globalPink,
                    title: StringExtensions.confirmAdditionalCards,
                    onTap: () async {
                      final currentCards =
                          await _viewModel.getPaymentMethodsOnce();

                      if (currentCards.length >= 5) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('You can register up to 5 accounts only.'),
                          ),
                        );
                        return; // Stop execution if there are already 5 tokens
                      }

                      final cardNumber = cardNumberController.text;
                      final isCardExists =
                          await _viewModel.isCardNumberExists(cardNumber);

                      if (isCardExists) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Card number already exists!'),
                          ),
                        );
                      } else {
                        Payment paymentModel = Payment(
                          cardNumber: cardNumber,
                          expiryDate: expiryDateController.text,
                          cvc: cvcController.text,
                          cardName: cardNameController.text,
                          paymentMethod: getPaymentMethod(),
                        );
                        await _viewModel.insertPaymentMethodNew(paymentModel);
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
