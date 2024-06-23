part of 'food_bloc.dart';

sealed class FoodEvent {}

class FoodStarted extends FoodEvent {
  final int id;
  FoodStarted({required this.id});
}
