part of 'restaurant_bloc.dart';

sealed class RestaurantEvent {}

class RestaurantInforStarted extends RestaurantEvent {
  final int id;

  RestaurantInforStarted({required this.id});
}

class RestaurantListStarted extends RestaurantEvent {
  final int size;
  final LocationBloc locationBloc;

  RestaurantListStarted({this.size = 5, required this.locationBloc });
}

class CalMoveTimeStarted extends RestaurantEvent {}
