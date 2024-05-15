class Payment {
  final String cardNumber;
  final String expiryDate;
  final String cvc;
  final String cardName;
  final String paymentMethod;

  Payment({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvc,
    required this.cardName,
    required this.paymentMethod,
  });

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      cardNumber: map['card_number'],
      expiryDate: map['expiry_date'],
      cvc: map['cvc'],
      cardName: map['card_name'],
      paymentMethod: map['payment_method'],
    );
  }
}

List<Payment> mapToPaymentList(List<Map<String, dynamic>> data) {
  return data.map((item) => Payment.fromMap(item)).toList();
}
