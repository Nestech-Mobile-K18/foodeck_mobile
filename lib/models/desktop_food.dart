import 'package:flutter/cupertino.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';

class TopFood extends ChangeNotifier {
  final List<DesktopFood> _desktopFood = [
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
  ];

  List<DesktopFood> get desktopFood => _desktopFood;
}
