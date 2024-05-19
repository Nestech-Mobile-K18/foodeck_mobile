class Payment {
  final String cardName;
  final String cardNbr;
  final String expiryDate;
  final String cvc;
  final String? image;
  const Payment(
      {required this.cardName,
      required this.cardNbr,
      required this.expiryDate,
      required this.cvc,
      this.image});
}
