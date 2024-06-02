part of 'restaurant_addon_bloc.dart';

sealed class RestaurantAddonEvent extends Equatable {
  final FoodItems foodItems;
  final RestaurantModel restaurant;

  const RestaurantAddonEvent(
      {required this.foodItems, required this.restaurant});

  @override
  // TODO: implement props
  List<Object?> get props => [foodItems, restaurant];
}

class RestaurantAddonInitialEvent extends RestaurantAddonEvent {
  const RestaurantAddonInitialEvent(
      {required super.foodItems, required super.restaurant});
}

class RestaurantPickSizeEvent extends RestaurantAddonEvent {
  final RadioType turnOn;

  const RestaurantPickSizeEvent(
      {required this.turnOn,
      required super.foodItems,
      required super.restaurant});
}

class RestaurantIncreaseQuantityEvent extends RestaurantAddonEvent {
  const RestaurantIncreaseQuantityEvent(
      {required super.foodItems, required super.restaurant});
}

class RestaurantRepeatIncreaseQuantityEvent extends RestaurantAddonEvent {
  const RestaurantRepeatIncreaseQuantityEvent(
      {required super.foodItems, required super.restaurant});
}

class RestaurantDecreaseQuantityEvent extends RestaurantAddonEvent {
  const RestaurantDecreaseQuantityEvent(
      {required super.foodItems, required super.restaurant});
}

class RestaurantRepeatDecreaseQuantityEvent extends RestaurantAddonEvent {
  const RestaurantRepeatDecreaseQuantityEvent(
      {required super.foodItems, required super.restaurant});
}

class RestaurantPickAddonEvent extends RestaurantAddonEvent {
  final int index;

  const RestaurantPickAddonEvent(
      {required super.foodItems,
      required super.restaurant,
      required this.index});
}

class RestaurantAddonNavigateToCartEvent extends RestaurantAddonEvent {
  final BuildContext context;

  const RestaurantAddonNavigateToCartEvent(
      {required super.foodItems,
      required super.restaurant,
      required this.context});
}
