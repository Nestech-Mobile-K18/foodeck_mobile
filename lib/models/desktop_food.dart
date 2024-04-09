import 'package:flutter/material.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';

class TopFood extends ChangeNotifier {
  List<DesktopFood> kindFood(TitleFood titleFood, List<DesktopFood> fullMenu) {
    return fullMenu.where((food) => food.titleFood == titleFood).toList();
  }

  final List<DesktopFood> _topFood = desktopFood;

  List<DesktopFood> get topFood => _topFood;
  final List<DesktopFood> _saveFood = [];

  List<DesktopFood> get saveFood => _saveFood;

  void addToList(DesktopFood desktopFood) {
    _saveFood.add(desktopFood);
    notifyListeners();
  }

  void removeFromList(DesktopFood desktopFood) {
    _saveFood.remove(desktopFood);
    notifyListeners();
  }
}

final List<DesktopFood> desktopFood = [
  DesktopFood(
      foodOrder: dailyDeli,
      time: '40 min',
      shopName: 'Daily Deli\n',
      place: 'Johar Town',
      vote: '4.8',
      titleFood: TitleFood.Deals),
  DesktopFood(
      foodOrder: riceBowl,
      time: '12 min',
      shopName: 'Rice Bowl\n',
      place: 'Wapda Town',
      vote: '4.8',
      titleFood: TitleFood.Deals),
  DesktopFood(
      foodOrder: healthyFood,
      time: '25 min',
      shopName: 'Healthy Food\n',
      place: 'Grand Town',
      vote: '4.4',
      titleFood: TitleFood.Deals),
  DesktopFood(
      foodOrder: indonesianFood,
      time: '30 min',
      shopName: 'Indonesian Food\n',
      place: 'Rolan Town',
      vote: '5',
      titleFood: TitleFood.Deals),
  DesktopFood(
      foodOrder: coffee,
      time: '15 min',
      shopName: 'Coffee\n',
      place: 'Mid Town',
      vote: '4.7',
      titleFood: TitleFood.Deals),
  DesktopFood(
      foodOrder: cake,
      time: '40 min',
      shopName: 'Jean’s Cakes\n',
      place: 'Johar Town',
      vote: '4.8',
      titleFood: TitleFood.Explore),
  DesktopFood(
      foodOrder: chocolate,
      time: '20 min',
      shopName: 'Thicc Shakes\n',
      place: 'Wapda Town',
      vote: '4.5',
      titleFood: TitleFood.Explore),
  DesktopFood(
      foodOrder: panCake,
      time: '30 min',
      shopName: 'Daily Deli\n',
      place: 'Garden Town',
      vote: '4.8',
      titleFood: TitleFood.Explore),
  DesktopFood(
      foodOrder: redGrape,
      time: '\$18',
      shopName: 'Red Grape Margarita\n',
      place: 'Daily Deli',
      vote: '4.8',
      titleFood: TitleFood.Popular),
  DesktopFood(
      foodOrder: lemonade,
      time: '\$12',
      shopName: 'Lemon Pina Colada\n',
      place: 'Arfan Juices',
      vote: '4.8',
      titleFood: TitleFood.Popular),
];
