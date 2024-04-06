import 'package:template/values/list.dart';

class CartItems {
  CartItems(
      {required this.foodItems, required this.selectAddon, this.quantity = 1});

  final FoodItems foodItems;
  final List<Addon> selectAddon;
  int quantity;

  double get totalPrice {
    double addonPrice = selectAddon.fold(
        0, (previousValue, element) => previousValue + element.price);
    return (foodItems.price + addonPrice) * quantity;
  }
}
