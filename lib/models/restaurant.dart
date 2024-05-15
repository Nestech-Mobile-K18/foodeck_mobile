import 'package:template/source/export.dart';

class Restaurant extends ChangeNotifier {
  // phân loại thức ăn theo menu
  List<FoodItems> filterCategory(
      FoodCategory foodCategory, List<FoodItems> fullMenu) {
    return fullMenu.where((food) => food.foodCategory == foodCategory).toList();
  }

  // phân loại topping theo món ăn
  List<Addon> choseTopping(RadioType radioType, List<Addon> full) {
    return full.where((addon) => addon.radio == radioType).toList();
  }

  //
  List<Widget> sortFood(List<FoodItems> fullMenu, DesktopFood desktopFood) {
    return FoodCategory.values.map((category) {
      List<FoodItems> categoryMenu = filterCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ListFood(
            voidCallback: () {
              final food = categoryMenu[index];
              Navigator.pushNamed(context, AppRouter.detailFood,
                  arguments:
                      DetailFood(foodItems: food, desktopFood: desktopFood));
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
  final List<OrderHistory> _orderComplete = [];

  List<OrderHistory> get orderComplete => _orderComplete;

  addToOrderComplete(int subPrice, int deliveryFee, int vat, int coupon,
      int totalPrice, String date, String restaurantName) {
    _orderComplete.add(OrderHistory(subPrice, deliveryFee, vat, coupon,
        totalPrice, date, cartItems, restaurantName));
  }

  void removeFromList(CartItems cartItems) {
    _cartItems.remove(cartItems);
    notifyListeners();
  }

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
      picture: Assets.pizza,
      nameFood: 'Chicken Fajita Pizza',
      detail: '8” pizza with regular soft drink',
      price: 10,
      place: 'Daily Deli - Johar Town',
      foodCategory: FoodCategory.Popular,
      availableAddons: addonItems),
  FoodItems(
      picture: Assets.friedChicken,
      nameFood: 'Chicken Fajita Pizza',
      detail: '8” pizza with regular soft drink',
      price: 10,
      place: 'Daily Deli - Johar Town',
      foodCategory: FoodCategory.Popular,
      availableAddons: addonItems),
  FoodItems(
      picture: Assets.coffeeMilk,
      nameFood: 'Deal 1',
      detail: '1 regular burger with\ncroquette and hot cocoa',
      price: 12,
      place: 'Daily Deli - Johar Town',
      foodCategory: FoodCategory.Deals,
      availableAddons: addonItems),
  FoodItems(
      picture: Assets.hamburger,
      nameFood: 'Deal 2',
      detail: '1 regular burger with\nsmall fries',
      price: 6,
      place: 'Daily Deli - Johar Town',
      foodCategory: FoodCategory.Deals,
      availableAddons: addonItems),
  FoodItems(
      picture: Assets.desert,
      nameFood: 'Deal 3',
      detail: '2 pieces of beef stew with\nhomemade sauce',
      price: 23,
      place: 'Daily Deli - Johar Town',
      foodCategory: FoodCategory.Deals,
      availableAddons: addonItems),
  FoodItems(
      picture: Assets.redGrape,
      price: 18,
      nameFood: 'Red Grape Margarita',
      place: 'Daily Deli',
      detail: '',
      foodCategory: FoodCategory.Beverages,
      availableAddons: addonItems),
  FoodItems(
      picture: Assets.lemonade,
      price: 12,
      nameFood: 'Lemon Pina Colada',
      place: 'Arfan Juices',
      detail: '',
      foodCategory: FoodCategory.Beverages,
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
