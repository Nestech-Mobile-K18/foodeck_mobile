part of 'restaurant_page_bloc.dart';

sealed class RestaurantPageEvent extends Equatable {
  const RestaurantPageEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RestaurantPageBackEvent extends RestaurantPageEvent {}

class RestaurantPageShareEvent extends RestaurantPageEvent {}

class RestaurantPageReportEvent extends RestaurantPageEvent {}

class RestaurantPageReviewEvent extends RestaurantPageEvent {}

class RestaurantPageMapEvent extends RestaurantPageEvent {}

class RestaurantPageNavigateEvent extends RestaurantPageEvent {
  final FoodItems foodItems;
  final DesktopFood desktopFood;

  const RestaurantPageNavigateEvent(
      {required this.foodItems, required this.desktopFood});
}