class RestaurantModel {
  final String image;
  final num deliveryTime;
  final String shopName;
  final String address;
  final num rate;
  final TitleFood titleFood;

  RestaurantModel(
      {required this.image,
      required this.deliveryTime,
      required this.shopName,
      required this.address,
      required this.rate,
      required this.titleFood});
}

enum TitleFood { Deals, Explore, Recent }

class FoodItems {
  final String picture;
  final String nameFood;
  final String detail;
  final int price;
  final String place;
  int quantityFood;

  final FoodCategory foodCategory;

  List<Addon> availableAddons;

  FoodItems(
      {this.quantityFood = 1,
      required this.place,
      required this.picture,
      required this.nameFood,
      required this.detail,
      required this.price,
      required this.foodCategory,
      required this.availableAddons});
}

enum FoodCategory { Popular, Deals, Wraps, Beverages, Sandwiches }

class Addon {
  final String addonName;
  final String size;
  final int priceSize;
  final int price;
  RadioType radio;

  Addon(
      {required this.radio,
      required this.addonName,
      required this.size,
      required this.priceSize,
      required this.price});
}

enum RadioType { a, b, c }

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
  int price;
  int quantity;
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
