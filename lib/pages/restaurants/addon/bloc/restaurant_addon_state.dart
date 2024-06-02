part of 'restaurant_addon_bloc.dart';

sealed class RestaurantAddonState extends Equatable {
  const RestaurantAddonState();

  @override
  List<Object> get props => [];
}

class RestaurantAddonActionState extends RestaurantAddonState {}

final class RestaurantAddonInitial extends RestaurantAddonState {}

class RestaurantAddonLoadingState extends RestaurantAddonState {}

class RestaurantAddonLoadingSuccessState extends RestaurantAddonState {
  final RestaurantModel restaurant;
  final FoodItems foodItems;

  const RestaurantAddonLoadingSuccessState(
      {required this.restaurant, required this.foodItems});
}

class RestaurantPickSizeState extends RestaurantAddonState {}

class RestaurantIncreaseQuantityState extends RestaurantAddonState {}

class RestaurantRepeatIncreaseQuantityState extends RestaurantAddonState {}

class RestaurantDecreaseQuantityState extends RestaurantAddonState {}

class RestaurantRepeatDecreaseQuantityState extends RestaurantAddonState {}

class RestaurantPickAddonState extends RestaurantAddonState {}

class RestaurantAddonNavigateToCartState extends RestaurantAddonActionState {}
