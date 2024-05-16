part of 'explore_page_bloc.dart';

sealed class ExplorePageEvent extends Equatable {
  const ExplorePageEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ExplorePageInitialEvent extends ExplorePageEvent {}

class ExplorePageSearchNavigateEvent extends ExplorePageEvent {}

class ExplorePageNavigateEvent extends ExplorePageEvent {
  final RestaurantModel restaurantModel;

  const ExplorePageNavigateEvent({required this.restaurantModel});
}

class ExplorePageCartNavigateEvent extends ExplorePageEvent {}

class ExplorePageLikeEvent extends ExplorePageEvent {
  final RestaurantModel saveFood;

  const ExplorePageLikeEvent({required this.saveFood});
}
