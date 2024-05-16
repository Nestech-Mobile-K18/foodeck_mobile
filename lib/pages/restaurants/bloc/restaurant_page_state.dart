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
  final List<RestaurantModel> restaurant;

  const RestaurantPageLoadingSuccessState({required this.restaurant});
}

class RestaurantPageBackState extends RestaurantPageActionState {}

class RestaurantPageShareState extends RestaurantPageActionState {}

class RestaurantPageReportState extends RestaurantPageActionState {}

class RestaurantPageReviewState extends RestaurantPageActionState {}

class RestaurantPageMapState extends RestaurantPageActionState {}

class RestaurantPageNavigateState extends RestaurantPageActionState {}
