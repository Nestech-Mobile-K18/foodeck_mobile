part of 'restaurant_cart_bloc.dart';

sealed class RestaurantCartState extends Equatable {
  const RestaurantCartState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RestaurantCartActionState extends RestaurantCartState {}

final class RestaurantCartInitial extends RestaurantCartState {
  @override
  List<Object> get props => [];
}

class RestaurantCartLoadingState extends RestaurantCartState {}

class RestaurantCartLoadedState extends RestaurantCartState {
  final List<CartItems> cartItems;

  const RestaurantCartLoadedState({required this.cartItems});
}

class RestaurantCartRemoveItemState extends RestaurantCartState {}

class RestaurantCartNavigateToCheckOutState extends RestaurantCartActionState {}
