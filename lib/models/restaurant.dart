import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/pages/deals/detail_page/cart_items.dart';
import 'package:template/pages/deals/detail_page/detail_food.dart';
import 'package:template/pages/deals/widget/list_food.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';

class Restaurant extends ChangeNotifier {
  List<FoodItems> _filterCategory(
      FoodCategory foodCategory, List<FoodItems> fullMenu) {
    return fullMenu.where((food) => food.foodCategory == foodCategory).toList();
  }

  List<Widget> sortFood(List<FoodItems> fullMenu) {
    return FoodCategory.values.map((category) {
      List<FoodItems> categoryMenu = _filterCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ListFood(
            voidCallback: () {
              final food = categoryMenu[index];
              Get.to(
                  () => DetailFood(
                        foodItems: food,
                      ),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 600));
            },
            picture: categoryMenu[index].picture,
            nameFood: categoryMenu[index].nameFood,
            detail: categoryMenu[index].detail,
            price: categoryMenu[index].price.toString()),
      );
    }).toList();
  }

  final List<FoodItems> menu = [
    FoodItems(
        picture: pizza,
        nameFood: 'Chicken Fajita Pizza\n',
        detail: '8” pizza with regular soft drink\n',
        price: 10,
        place: 'Daily Deli - Johar Town',
        foodCategory: FoodCategory.Popular,
        availableAddons: [Addon('Texas Barbeque', 6), Addon('Char Donay', 8)]),
    FoodItems(
        picture: friedChicken,
        nameFood: 'Chicken Fajita Pizza\n',
        detail: '8” pizza with regular soft drink\n',
        price: 10,
        place: 'Daily Deli - Johar Town',
        foodCategory: FoodCategory.Popular,
        availableAddons: [Addon('Texas Barbeque', 6), Addon('Char Donay', 8)]),
    FoodItems(
        picture: coffeeMilk,
        nameFood: 'Deal 1\n',
        detail: '1 regular burger with\ncroquette and hot cocoa\n',
        price: 12,
        place: 'Daily Deli - Johar Town',
        foodCategory: FoodCategory.Deals,
        availableAddons: [Addon('Texas Barbeque', 6), Addon('Char Donay', 8)]),
    FoodItems(
        picture: hamburger,
        nameFood: 'Deal 2\n',
        detail: '1 regular burger with\nsmall fries\n',
        price: 6,
        place: 'Daily Deli - Johar Town',
        foodCategory: FoodCategory.Deals,
        availableAddons: [Addon('Texas Barbeque', 6), Addon('Char Donay', 8)]),
    FoodItems(
        picture: desert,
        nameFood: 'Deal 3\n',
        detail: '2 pieces of beef stew with\nhomemade sauce\n',
        price: 23,
        place: 'Daily Deli - Johar Town',
        foodCategory: FoodCategory.Deals,
        availableAddons: [
          Addon('Texas Barbeque', 6),
          Addon('Char Donay', 8),
        ]),
  ];

  final List<CartItems> cart = [];

  // add to cart
  void addToCart(FoodItems foodItems, List<Addon> select) {
    CartItems? cartItem = cart.firstWhereOrNull((element) {
      bool isSameFood = element.foodItems == foodItems;
      // use Collection package in here
      bool isSameAddon = ListEquality().equals(element.selectAddon, select);
      return isSameFood && isSameAddon;
    });
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      cart.add(CartItems(foodItems: foodItems, selectAddon: select));
    }
    notifyListeners();
  }

  // remove from cart
  void removeFromCart(CartItems cartItems) {
    int cartIndex = cart.indexOf(cartItems);
    if (cartIndex != -1) {
      if (cart[cartIndex].quantity > 1) {
        cart[cartIndex].quantity--;
      } else {
        cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // get total price from cart
  double totalPrice() {
    double total = 0.0;
    for (CartItems cartItems in cart) {
      double itemTotal = cartItems.foodItems.price.toDouble();
      for (Addon addon in cartItems.selectAddon) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItems.quantity;
    }
    return total;
  }

  // get total number of items in the cart
  int getTotalItemCount() {
    int total = 0;
    for (CartItems cartItems in cart) {
      total += cartItems.quantity;
    }
    return total;
  }

  // clear cart
  void clearCart() {
    cart.clear();
    notifyListeners();
  }
}
