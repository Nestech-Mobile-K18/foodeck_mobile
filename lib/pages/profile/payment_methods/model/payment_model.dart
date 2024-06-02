import 'package:template/source/export.dart';

class PaymentModel {
  final String cardName, cardNumber;
  final CardType cardType;

  PaymentModel(
      {required this.cardName,
      required this.cardNumber,
      required this.cardType});
}

List<PaymentModel> card = [];
