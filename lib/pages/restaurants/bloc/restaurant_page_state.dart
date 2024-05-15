part of 'restaurant_page_bloc.dart';

sealed class RestaurantPageState extends Equatable {
  const RestaurantPageState();

  @override
  List<Object> get props => [];
}

class RestaurantPageActionState extends RestaurantPageState {}

final class RestaurantPageInitial extends RestaurantPageState {}

class RestaurantPageBackState extends RestaurantPageActionState {}

class RestaurantPageShareState extends RestaurantPageActionState {}

class RestaurantPageReportState extends RestaurantPageActionState {}

class RestaurantPageReviewState extends RestaurantPageActionState {}

class RestaurantPageMapState extends RestaurantPageActionState {}

class RestaurantPageNavigateState extends RestaurantPageActionState {
  final FoodItems foodItems;
  final DesktopFood desktopFood;

  RestaurantPageNavigateState(
      {required this.foodItems, required this.desktopFood});
}
