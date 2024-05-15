import 'package:template/values/list.dart';

class CartItems {
  CartItems(
      {required this.foodItems,
      required this.size,
      required this.price,
      required this.selectAddon,
      required this.note,
      this.quantity = 1});

  final FoodItems foodItems;
  final List<String> selectAddon;
  final List<String> size;
  final String note;
  final int price;
  int quantity;

// double get totalPrice {
//   double addonPrice = selectAddon.fold(
//       0, (previousValue, element) => previousValue + element.price);
//   return (foodItems.price + addonPrice) * quantity;
// }
}

class OrderHistory {
  final String restaurantName;
  final List res;
  final int subPrice;
  final int deliveryFee;
  final int vat;
  final int coupon;
  final int totalPrice;
  final String date;

  OrderHistory(this.subPrice, this.deliveryFee, this.vat, this.coupon,
      this.totalPrice, this.date, this.res, this.restaurantName);
}
