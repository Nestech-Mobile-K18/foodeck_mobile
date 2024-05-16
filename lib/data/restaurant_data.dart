import 'package:template/source/export.dart';

class RestaurantData {
  static List<RestaurantModel> restaurant = [
    RestaurantModel(
        image: Assets.dailyDeli,
        deliveryTime: 40,
        shopName: 'Daily Deli',
        address: 'Johar Town',
        rate: 4.8,
        titleFood: TitleFood.Deals),
    RestaurantModel(
        image: Assets.riceBowl,
        deliveryTime: 12,
        shopName: 'Rice Bowl',
        address: 'Wapda Town',
        rate: 4.8,
        titleFood: TitleFood.Deals),
    RestaurantModel(
        image: Assets.healthyFood,
        deliveryTime: 25,
        shopName: 'Healthy Food',
        address: 'Grand Town',
        rate: 4.4,
        titleFood: TitleFood.Deals),
    RestaurantModel(
        image: Assets.indonesianFood,
        deliveryTime: 30,
        shopName: 'Indonesian Food',
        address: 'Rolan Town',
        rate: 5,
        titleFood: TitleFood.Deals),
    RestaurantModel(
        image: Assets.coffee,
        deliveryTime: 15,
        shopName: 'Coffee',
        address: 'Mid Town',
        rate: 4.7,
        titleFood: TitleFood.Deals),
    RestaurantModel(
        image: Assets.cake,
        deliveryTime: 40,
        shopName: 'Jean’s Cakes',
        address: 'Johar Town',
        rate: 4.8,
        titleFood: TitleFood.Explore),
    RestaurantModel(
        image: Assets.chocolate,
        deliveryTime: 20,
        shopName: 'Thicc Shakes',
        address: 'Wapda Town',
        rate: 4.5,
        titleFood: TitleFood.Explore),
    RestaurantModel(
        image: Assets.panCake,
        deliveryTime: 30,
        shopName: 'Daily Deli',
        address: 'Garden Town',
        rate: 4.8,
        titleFood: TitleFood.Explore),
    RestaurantModel(
        image: Assets.burger,
        deliveryTime: 38,
        shopName: 'Burger King',
        address: 'Mappa Town',
        rate: 3.3,
        titleFood: TitleFood.Recent),
    RestaurantModel(
        image: Assets.crepe,
        deliveryTime: 42,
        shopName: 'Wrap Factory',
        address: 'Kenny Town',
        rate: 4.3,
        titleFood: TitleFood.Recent),
  ];
  static List<FoodItems> foodItems = [
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
  static List<Addon> addonItems = [
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
    Addon(
        addonName: '', size: '12"', priceSize: 16, price: 0, radio: RadioType.c)
  ];

  static List<RestaurantModel> kindFood(
      TitleFood titleFood, List<RestaurantModel> fullMenu) {
    return fullMenu.where((food) => food.titleFood == titleFood).toList();
  }

  // phân loại thức ăn theo menu
  static List<FoodItems> filterCategory(
      FoodCategory foodCategory, List<FoodItems> fullMenu) {
    return fullMenu.where((food) => food.foodCategory == foodCategory).toList();
  }

  // phân loại topping theo món ăn
  static List<Addon> choseTopping(RadioType radioType, List<Addon> full) {
    return full.where((addon) => addon.radio == radioType).toList();
  }

  static Future saveBanner(BuildContext context, String food, num timeDelivery,
      String shopName, String place, num vote) async {
    try {
      await supabase.from('items').upsert({
        'food': food,
        'time_delivery': timeDelivery,
        'shop_name': shopName,
        'place': place,
        'vote': vote
      }).then((value) => CustomWidgets.customSnackBar(
          context, AppColor.globalPinkShadow, 'You just liked this item'));
    } on AuthException catch (error) {
      CustomWidgets.customSnackBar(
          context, AppColor.buttonShadowBlack, error.message);
    } catch (error) {
      CustomWidgets.customSnackBar(
          context, AppColor.buttonShadowBlack, 'Error occurred, please retry');
    }
  }

  static Future deleteBanner(BuildContext context, String food,
      num timeDelivery, String shopName, String place, num vote) async {
    try {
      await supabase.from('items').delete().match({
        'food': food,
        'time_delivery': timeDelivery,
        'shop_name': shopName,
        'place': place,
        'vote': vote
      }).then((value) => CustomWidgets.customSnackBar(
          context, AppColor.buttonShadowBlack, 'You just unliked this item'));
    } on AuthException catch (error) {
      CustomWidgets.customSnackBar(
          context, AppColor.buttonShadowBlack, error.message);
    } catch (error) {
      CustomWidgets.customSnackBar(
          context, AppColor.buttonShadowBlack, 'Error occurred, please retry');
    }
  }
}
