import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

part 'restaurant_addon_event.dart';
part 'restaurant_addon_state.dart';

class RestaurantAddonBloc
    extends Bloc<RestaurantAddonEvent, RestaurantAddonState> {
  RadioType turnOn = RadioType.a;
  final noteController = TextEditingController();
  List<bool> like = [false, false];
  List<int> slot = [0, 0];

  RestaurantAddonBloc() : super(RestaurantAddonInitial()) {
    on<RestaurantAddonInitialEvent>(restaurantAddonInitialEvent);
    on<RestaurantPickSizeEvent>(restaurantPickSizeEvent);
    on<RestaurantIncreaseQuantityEvent>(restaurantIncreaseQuantityEvent);
    on<RestaurantRepeatIncreaseQuantityEvent>(
        restaurantRepeatIncreaseQuantityEvent);
    on<RestaurantRepeatDecreaseQuantityEvent>(
        restaurantRepeatDecreaseQuantityEvent);
    on<RestaurantDecreaseQuantityEvent>(restaurantDecreaseQuantityEvent);
    on<RestaurantPickAddonEvent>(restaurantPickAddonEvent);
    on<RestaurantAddonNavigateToCartEvent>(restaurantAddonNavigateToCartEvent);
  }

  FutureOr<void> restaurantAddonInitialEvent(
      RestaurantAddonInitialEvent event, Emitter<RestaurantAddonState> emit) {
    emit(RestaurantAddonLoadingState());
    emit(RestaurantAddonLoadingSuccessState(
        restaurant: event.restaurant, foodItems: event.foodItems));
  }

  FutureOr<void> restaurantPickSizeEvent(
      RestaurantPickSizeEvent event, Emitter<RestaurantAddonState> emit) {
    turnOn = event.turnOn;
    emit(RestaurantPickSizeState());
    emit(RestaurantAddonLoadingSuccessState(
        restaurant: event.restaurant, foodItems: event.foodItems));
  }

  FutureOr<void> restaurantIncreaseQuantityEvent(
      RestaurantIncreaseQuantityEvent event,
      Emitter<RestaurantAddonState> emit) {
    event.foodItems.quantityFood++;
    emit(RestaurantIncreaseQuantityState());
    emit(RestaurantAddonLoadingSuccessState(
        restaurant: event.restaurant, foodItems: event.foodItems));
  }

  FutureOr<void> restaurantRepeatIncreaseQuantityEvent(
      RestaurantRepeatIncreaseQuantityEvent event,
      Emitter<RestaurantAddonState> emit) {
    event.foodItems.quantityFood++;
    emit(RestaurantRepeatIncreaseQuantityState());
    emit(RestaurantAddonLoadingSuccessState(
        restaurant: event.restaurant, foodItems: event.foodItems));
  }

  FutureOr<void> restaurantRepeatDecreaseQuantityEvent(
      RestaurantRepeatDecreaseQuantityEvent event,
      Emitter<RestaurantAddonState> emit) {
    event.foodItems.quantityFood--;
    emit(RestaurantRepeatDecreaseQuantityState());
    emit(RestaurantAddonLoadingSuccessState(
        restaurant: event.restaurant, foodItems: event.foodItems));
  }

  FutureOr<void> restaurantDecreaseQuantityEvent(
      RestaurantDecreaseQuantityEvent event,
      Emitter<RestaurantAddonState> emit) {
    event.foodItems.quantityFood--;
    emit(RestaurantDecreaseQuantityState());
    emit(RestaurantAddonLoadingSuccessState(
        restaurant: event.restaurant, foodItems: event.foodItems));
  }

  FutureOr<void> restaurantPickAddonEvent(
      RestaurantPickAddonEvent event, Emitter<RestaurantAddonState> emit) {
    getAddonPrice(event.index);
    emit(RestaurantPickAddonState());
    emit(RestaurantAddonLoadingSuccessState(
        restaurant: event.restaurant, foodItems: event.foodItems));
  }

  FutureOr<void> restaurantAddonNavigateToCartEvent(
      RestaurantAddonNavigateToCartEvent event,
      Emitter<RestaurantAddonState> emit) {
    addToCart(event.foodItems, turnOn, noteController, event.context);
    emit(RestaurantAddonNavigateToCartState());
    emit(RestaurantAddonLoadingSuccessState(
        restaurant: event.restaurant, foodItems: event.foodItems));
  }

  void getAddonPrice(int index) {
    switch (index) {
      case 0:
        like[0] = !like[0];
        like[0] ? slot[0] = RestaurantData.addonItems[0].price : slot[0] = 0;
        break;
      case 1:
        like[1] = !like[1];
        like[1] ? slot[1] = RestaurantData.addonItems[1].price : slot[1] = 0;
        break;
    }
  }

  int totalPrice(RadioType turnOn, int quantityFood) {
    int addonPriceSize =
        RestaurantData.choseTopping(turnOn, RestaurantData.addonItems).fold(
            0, (previousValue, element) => previousValue + element.priceSize);
    return (slot[0] + slot[1] + addonPriceSize) * quantityFood;
  }

  void addToCart(FoodItems foodItems, RadioType turnOn,
      TextEditingController noteController, BuildContext context) {
    List<String> currentSelect = [];
    like[0] == true
        ? currentSelect.add(RestaurantData.addonItems[0].addonName)
        : currentSelect.add('');
    like[1] == true
        ? currentSelect.add(RestaurantData.addonItems[1].addonName)
        : currentSelect.add('');
    List<String> currentSize = [];
    currentSize.add(
        RestaurantData.choseTopping(turnOn, RestaurantData.addonItems)
            .elementAt(0)
            .size);
    CartItems? cart = CartItemsListData.cartItems.firstWhereOrNull((element) {
      bool isSameFood = element.foodItems == foodItems;
      bool isSameNote = element.note == noteController.text;
      bool isSameSize = const ListEquality().equals(element.size, currentSize);
      bool isSameAddon =
          const ListEquality().equals(element.selectAddon, currentSelect);
      return isSameFood && isSameNote && isSameSize && isSameAddon;
    });
    if (cart != null) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: const CustomText(
                    content: 'Are you want to increase quantity?',
                    textOverflow: TextOverflow.visible),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        RiveUtils.changeSMITriggerState(
                            RiveUtils.addToCartModel.statusTrigger!);
                        cart.quantity += foodItems.quantityFood;
                        cart.price +=
                            totalPrice(turnOn, foodItems.quantityFood);
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRouter.restaurantCart);
                      },
                      child: const CustomText(content: 'Yes')),
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const CustomText(content: 'No')),
                ],
              ));
    } else {
      RiveUtils.changeSMITriggerState(RiveUtils.addToCartModel.statusTrigger!);
      CartItemsListData.cartItems.add(CartItems(
          note: noteController.text,
          foodItems: foodItems,
          size: currentSize,
          price: totalPrice(turnOn, foodItems.quantityFood),
          selectAddon: currentSelect,
          quantity: foodItems.quantityFood));
      Future.delayed(const Duration(milliseconds: 3300),
          () => Navigator.pushNamed(context, AppRouter.restaurantCart));
    }
  }
}
