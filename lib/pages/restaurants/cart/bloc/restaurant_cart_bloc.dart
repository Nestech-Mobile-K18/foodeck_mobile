import 'package:template/source/export.dart';

part 'restaurant_cart_event.dart';
part 'restaurant_cart_state.dart';

class RestaurantCartBloc
    extends Bloc<RestaurantCartEvent, RestaurantCartState> {
  int currentCard = 0;
  int deliveryFee = 10;
  int vat = 4;
  int coupon = 4;

  int get totalPrice {
    int addonPrice = CartItemsListData.cartItems
        .fold(0, (previousValue, element) => previousValue + element.price);
    return addonPrice;
  }

  int get bill {
    int getBill = totalPrice + deliveryFee + vat - coupon;
    return getBill;
  }

  RestaurantCartBloc() : super(RestaurantCartInitial()) {
    on<RestaurantCartInitialEvent>(restaurantCartInitialEvent);
    on<RestaurantCartRemoveItemEvent>(restaurantCartRemoveItemEvent);
    on<RestaurantCartNavigateToCheckOutEvent>(
        restaurantCartNavigateToCheckOutEvent);
  }

  FutureOr<void> restaurantCartInitialEvent(
      RestaurantCartInitialEvent event, Emitter<RestaurantCartState> emit) {
    emit(RestaurantCartLoadingState());
    emit(RestaurantCartLoadedState(cartItems: event.cartItems));
  }

  FutureOr<void> restaurantCartRemoveItemEvent(
      RestaurantCartRemoveItemEvent event, Emitter<RestaurantCartState> emit) {
    if (event.cartItems.length == 1) {
      event.cartItems.remove(event.cartItem);
      AppRouter.navigatorKey.currentState!.pop();
    } else {
      event.cartItems.remove(event.cartItem);
      emit(RestaurantCartRemoveItemState());
      emit(RestaurantCartLoadedState(cartItems: event.cartItems));
    }
  }

  FutureOr<void> restaurantCartNavigateToCheckOutEvent(
      RestaurantCartNavigateToCheckOutEvent event,
      Emitter<RestaurantCartState> emit) {
    emit(RestaurantCartNavigateToCheckOutState());
    emit(RestaurantCartLoadedState(cartItems: event.cartItems));
  }
}
