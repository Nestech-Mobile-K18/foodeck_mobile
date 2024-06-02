part of 'restaurant_cart_bloc.dart';

sealed class RestaurantCartEvent extends Equatable {
  final List<CartItems> cartItems;

  const RestaurantCartEvent({required this.cartItems});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RestaurantCartInitialEvent extends RestaurantCartEvent {
  const RestaurantCartInitialEvent({required super.cartItems});
}

class RestaurantCartRemoveItemEvent extends RestaurantCartEvent {
  final CartItems cartItem;

  const RestaurantCartRemoveItemEvent(
      {required this.cartItem, required super.cartItems});
}

class RestaurantCartNavigateToCheckOutEvent extends RestaurantCartEvent {
  const RestaurantCartNavigateToCheckOutEvent({required super.cartItems});
}
