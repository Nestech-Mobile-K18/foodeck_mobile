import 'package:flutter/cupertino.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';

class Restaurant extends ChangeNotifier {
  final List<FoodItems> _menu = [
    FoodItems(
        picture: pizza,
        nameFood: 'Chicken Fajita Pizza\n',
        detail: '8” pizza with regular soft drink\n',
        price: '\$10',
        foodCategory: FoodCategory.Popular),
    FoodItems(
        picture: friedChicken,
        nameFood: 'Chicken Fajita Pizza\n',
        detail: '8” pizza with regular soft drink\n',
        price: '\$10',
        foodCategory: FoodCategory.Popular),
    FoodItems(
        picture: coffeeMilk,
        nameFood: 'Deal 1\n',
        detail: '1 regular burger with\ncroquette and hot cocoa\n',
        price: '\$12',
        foodCategory: FoodCategory.Deals),
    FoodItems(
        picture: hamburger,
        nameFood: 'Deal 2\n',
        detail: '1 regular burger with small fries\n',
        price: '\$6',
        foodCategory: FoodCategory.Deals),
    FoodItems(
        picture: desert,
        nameFood: 'Deal 3\n',
        detail: '2 pieces of beef stew with\nhomemade sauce\n',
        price: '\$23',
        foodCategory: FoodCategory.Deals),
  ];

  List<FoodItems> get menu => _menu;
}
