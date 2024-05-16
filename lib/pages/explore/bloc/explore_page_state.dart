part of 'explore_page_bloc.dart';

sealed class ExplorePageState extends Equatable {
  const ExplorePageState();

  @override
  List<Object> get props => [];
}

class ExplorePageActionState extends ExplorePageState {}

final class ExplorePageInitial extends ExplorePageState {}

class ExplorePageLoadingState extends ExplorePageState {}

class ExplorePageLoadingSuccessState extends ExplorePageState {
  final List<RestaurantModel> restaurant;

  const ExplorePageLoadingSuccessState({required this.restaurant});
}

class ExplorePageLikeState extends ExplorePageActionState {
  final RestaurantModel restaurantModel;

  ExplorePageLikeState({required this.restaurantModel});
}

class ExplorePageSearchNavigateActionState extends ExplorePageActionState {}

class ExplorePageCartNavigateActionState extends ExplorePageActionState {}

class ExplorePageNavigateActionState extends ExplorePageActionState {
  final RestaurantModel restaurantModel;

  ExplorePageNavigateActionState({required this.restaurantModel});
}
