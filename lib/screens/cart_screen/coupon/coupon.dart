class Coupon {
  final String code;
  final double discount;

  Coupon({required this.code, required this.discount});
}

List<Coupon> coupon = [
  Coupon(
    code: "ABCD",
    discount: 4,
  ),
  Coupon(
    code: "DEFG",
    discount: 5,
  ),
  Coupon(
    code: "DISCOUNT20",
    discount: 0.2,
  ),
  Coupon(
    code: "DISCOUNT50",
    discount: 0.5,
  ),
];
