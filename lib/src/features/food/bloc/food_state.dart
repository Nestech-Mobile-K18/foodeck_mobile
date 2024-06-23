part of 'food_bloc.dart';

sealed class FoodState {}

class FoodInitial extends FoodState {
  final int id;
  final String name;
  final double price;
  final String? description;
  final String? image;
  FoodInitial({
    this.id = 0,
    this.name = '',
    this.price = 0,
    this.description = '',
    this.image = '',
  });
}

class FoodInProgress extends FoodState {
  final bool loading;

  FoodInProgress({this.loading = true});
}

class FoodSuccess extends FoodState {
  final int id;
  final String name;
  final double price;
  final String? description;
  final String? image;

  FoodSuccess({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.image,
  });
}

class FoodFailure extends FoodState {
  final int id;
  final String name;
  final double rate;

  FoodFailure({
    this.id = 0,
    this.name = '',
    this.rate = 0,
  });
}

class FoodReset extends FoodInitial {}
