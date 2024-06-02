part of 'restaurant_page_bloc.dart';

sealed class RestaurantPageEvent extends Equatable {
  const RestaurantPageEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RestaurantPageInitialEvent extends RestaurantPageEvent {
  final RestaurantModel restaurant;

  const RestaurantPageInitialEvent({required this.restaurant});
}

class RestaurantPageShareEvent extends RestaurantPageEvent {
  final RestaurantModel restaurant;

  const RestaurantPageShareEvent({required this.restaurant});
}

class RestaurantPageReportEvent extends RestaurantPageEvent {}

class RestaurantPageSetRateEvent extends RestaurantPageEvent {
  final double rate;

  const RestaurantPageSetRateEvent({required this.rate});
}

class RestaurantPageSentReviewEvent extends RestaurantPageEvent {
  final BuildContext context;
  final RestaurantModel restaurant;
  final TextEditingController reviewController;
  final double? rate;

  const RestaurantPageSentReviewEvent(
      {required this.context,
      required this.restaurant,
      required this.reviewController,
      this.rate = 1});
}

class RestaurantPageMapEvent extends RestaurantPageEvent {}

class RestaurantPageNavigateToAddonEvent extends RestaurantPageEvent {
  final FoodItems foodItems;
  final RestaurantModel restaurant;

  const RestaurantPageNavigateToAddonEvent(
      {required this.foodItems, required this.restaurant});
}
