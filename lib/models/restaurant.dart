import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/pages/deals/detail_page/cart_items.dart';
import 'package:template/pages/deals/detail_page/detail_food.dart';
import 'package:template/pages/deals/widget/list_food.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';

class Restaurant extends ChangeNotifier {
  // phân loại thức ăn theo menu
  List<FoodItems> _filterCategory(
      FoodCategory foodCategory, List<FoodItems> fullMenu) {
    return fullMenu.where((food) => food.foodCategory == foodCategory).toList();
  }

  // phân loại topping theo món ăn
  List<Addon> choseTopping(RadioType radioType, List<Addon> full) {
    return full.where((addon) => addon.radio == radioType).toList();
  }

  //
  List<Widget> sortFood(List<FoodItems> fullMenu) {
    return FoodCategory.values.map((category) {
      List<FoodItems> categoryMenu = _filterCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ListFood(
            voidCallback: () {
              final food = categoryMenu[index];
              Get.to(
                  () => DetailFood(
                        foodItems: food,
                        addon: addonItems[index],
                      ),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 600));
            },
            picture: categoryMenu[index].picture,
            nameFood: categoryMenu[index].nameFood,
            detail: categoryMenu[index].detail,
            price: '\$${categoryMenu[index].price}'),
      );
    }).toList();
  }

  final List<CartItems> _cartItems = [];

  List<CartItems> get cartItems => _cartItems;

  // add to cart
  // void addToCart(
  //     FoodItems foodItems, List<Addon> select, List<Addon> addon, double num) {
  //   // CartItems? cartItem = _cartItems.firstWhereOrNull((element) {
  //   //   bool isSameFood = element.foodItems == foodItems;
  //   //   // use Collection package in here
  //   //   bool isSameAddon =
  //   //       const ListEquality().equals(element.selectAddon, select);
  //   //   return isSameFood && isSameAddon;
  //   // });
  //   // if (cartItem != null) {
  //   //   cartItem.quantity++;
  //   // } else {
  //   _cartItems.add(CartItems(
  //       foodItems: foodItems, size: addon, price: num, selectAddon: select));
  //   // }
  //   notifyListeners();
  // }

  void removeFromList(CartItems cartItems) {
    _cartItems.remove(cartItems);
    notifyListeners();
  }

  // remove from cart
  void removeFromCart(CartItems cart) {
    int cartIndex = _cartItems.indexOf(cart);
    if (cartIndex != -1) {
      if (_cartItems[cartIndex].quantity > 1) {
        _cartItems[cartIndex].quantity--;
      } else {
        _cartItems.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // get total price from cart
  // double totalPrice() {
  //   double total = 0.0;
  //   for (CartItems _cartItems in _cartItems) {
  //     double itemTotal = _cartItems.foodItems.price.toDouble();
  //     for (Addon addon in _cartItems.selectAddon) {
  //       itemTotal += addon.price;
  //     }
  //     total += itemTotal * _cartItems.quantity;
  //   }
  //   return total;
  // }

  // get total number of items in the cart
  // int getTotalItemCount() {
  //   int total = 0;
  //   for (CartItems _cartItems in _cartItems) {
  //     total += _cartItems.quantity;
  //   }
  //   return total;
  // }

  // clear cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  final List<FoodItems> _menu = foodItems;

  List<FoodItems> get menu => _menu;

  void addQuantity(FoodItems foodItems) {
    foodItems.quantityFood++;
    notifyListeners();
  }

  void removeQuantity(FoodItems foodItems) {
    if (foodItems.quantityFood > 1) {
      foodItems.quantityFood--;
    } else {
      null;
    }

    notifyListeners();
  }
}

List<FoodItems> foodItems = [
  FoodItems(
      picture: pizza,
      nameFood: 'Chicken Fajita Pizza\n',
      detail: '8” pizza with regular soft drink\n',
      price: 10,
      place: 'Daily Deli - Johar Town',
      foodCategory: FoodCategory.Popular,
      availableAddons: addonItems),
  FoodItems(
      picture: friedChicken,
      nameFood: 'Chicken Fajita Pizza\n',
      detail: '8” pizza with regular soft drink\n',
      price: 10,
      place: 'Daily Deli - Johar Town',
      foodCategory: FoodCategory.Popular,
      availableAddons: addonItems),
  FoodItems(
      picture: coffeeMilk,
      nameFood: 'Deal 1\n',
      detail: '1 regular burger with\ncroquette and hot cocoa\n',
      price: 12,
      place: 'Daily Deli - Johar Town',
      foodCategory: FoodCategory.Deals,
      availableAddons: addonItems),
  FoodItems(
      picture: hamburger,
      nameFood: 'Deal 2\n',
      detail: '1 regular burger with\nsmall fries\n',
      price: 6,
      place: 'Daily Deli - Johar Town',
      foodCategory: FoodCategory.Deals,
      availableAddons: addonItems),
  FoodItems(
      picture: desert,
      nameFood: 'Deal 3\n',
      detail: '2 pieces of beef stew with\nhomemade sauce\n',
      price: 23,
      place: 'Daily Deli - Johar Town',
      foodCategory: FoodCategory.Deals,
      availableAddons: addonItems),
];
List<Addon> addonItems = [
  Addon(
      addonName: 'Texas Barbeque',
      size: '8"',
      priceSize: 10,
      price: 6,
      radio: RadioType.a),
  Addon(
      addonName: 'Char Donay',
      size: '10"',
      priceSize: 12,
      price: 8,
      radio: RadioType.b),
  Addon(addonName: '', size: '12"', priceSize: 16, price: 0, radio: RadioType.c)
];
