class CreditCardInfo {
  final String id;
  late bool isSelected;
  final String cardNumber;
  final String cardName;
  final String cardExpiryDate;
  final String cardCVC;

  CreditCardInfo(
      {required this.id,
      required this.isSelected,
      required this.cardNumber,
      required this.cardName,
      required this.cardExpiryDate,
      required this.cardCVC});
}

List<CreditCardInfo> creditCardInfo = [];
