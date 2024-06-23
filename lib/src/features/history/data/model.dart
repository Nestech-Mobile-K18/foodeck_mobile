import 'package:template/src/pages/export.dart';

class BillDetail {
  final String restaurant;
  final String date;
  final List<OrderSummary> orderSummary;
  final double subTotal;
  final double? fee;
  final double? vat;
  final double? coupon;
  final String deliveryAddress;
  final String? deliveryInstruction;
  final Payment? paymentInfo;
  const BillDetail(
      {required this.restaurant,
      required this.date,
      required this.orderSummary,
      required this.subTotal,
      this.fee,
      this.vat,
      this.coupon,
      required this.deliveryAddress,
      this.deliveryInstruction,
      this.paymentInfo});
}

// page checkout
// class OrderSummary {
//   final String foodName;
//   final double price;
//   final int quanity;
//   const OrderSummary(this.foodName, this.price, this.quanity);
// }

class Bill {
  final String date;
  final String id;
  final String restaurantName;
  final double total;
  const Bill(
      {required this.date,
      required this.id,
      required this.restaurantName,
      required this.total});
}
