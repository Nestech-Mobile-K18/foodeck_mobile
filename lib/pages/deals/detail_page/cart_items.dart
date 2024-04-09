import 'package:template/values/list.dart';

class CartItems {
  CartItems(
      {required this.foodItems,
      required this.size,
      required this.price,
      required this.selectAddon,
      this.quantity = 1});

  final FoodItems foodItems;
  final List<String> selectAddon;
  final List<String> size;
  final int price;
  int quantity;

// double get totalPrice {
//   double addonPrice = selectAddon.fold(
//       0, (previousValue, element) => previousValue + element.price);
//   return (foodItems.price + addonPrice) * quantity;
// }
}
