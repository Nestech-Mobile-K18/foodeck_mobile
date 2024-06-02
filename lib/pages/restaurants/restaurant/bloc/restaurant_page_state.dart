part of 'restaurant_page_bloc.dart';

sealed class RestaurantPageState extends Equatable {
  const RestaurantPageState();

  @override
  List<Object> get props => [];
}

class RestaurantPageActionState extends RestaurantPageState {}

final class RestaurantPageInitial extends RestaurantPageState {}

class RestaurantPageLoadingState extends RestaurantPageState {}

class RestaurantPageLoadingSuccessState extends RestaurantPageState {
  final RestaurantModel restaurant;

  const RestaurantPageLoadingSuccessState({required this.restaurant});
}

class RestaurantPageShareState extends RestaurantPageActionState {}

class RestaurantPageReportState extends RestaurantPageActionState {}

class RestaurantPageSetRateState extends RestaurantPageActionState {}

class RestaurantPageSentReviewState extends RestaurantPageActionState {}

class RestaurantPageMapState extends RestaurantPageActionState {}

class RestaurantPageNavigateToAddonState extends RestaurantPageActionState {
  final FoodItems foodItems;
  final RestaurantModel restaurant;

  RestaurantPageNavigateToAddonState(
      {required this.foodItems, required this.restaurant});
}
