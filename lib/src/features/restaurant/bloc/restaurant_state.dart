part of 'restaurant_bloc.dart';

sealed class RestaurantState {}

class RestaurantInitial extends RestaurantState {
  // final int id;
  // final String name;
  // final double rate;
  final List<RestaurantInfo>? restaurants;
  final List<CalMoveTime>? moveTimes;

  RestaurantInitial({ this.restaurants=const [], this.moveTimes = const []
      // this.id = 0,
      // this.name = '',
      // this.rate = 0,
      });

}

class RestaurantListInProgress extends RestaurantState {
  final bool loading;

  RestaurantListInProgress({this.loading = true});
}

class RestaurantListSuccess extends RestaurantState {
  final List<RestaurantInfo>? restaurants;

  RestaurantListSuccess({this.restaurants});
}

class RestaurantListFailure extends RestaurantState {
  final List<RestaurantInfo>? restaurants;

  RestaurantListFailure({this.restaurants = const []});
}

class CalMoveTimeInProgress extends RestaurantState {
  final bool loading;

  CalMoveTimeInProgress({this.loading = true});
}

class CalMoveTimeSuccess extends RestaurantState {
  final List<CalMoveTime>? moveTime;

  CalMoveTimeSuccess({this.moveTime});
}

class CalMoveTimeFailure extends RestaurantState {
  final List<CalMoveTime>? moveTime;

  CalMoveTimeFailure({this.moveTime = const []});
}
