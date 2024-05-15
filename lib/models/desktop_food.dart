import 'package:template/source/export.dart';

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
      foodOrder: Assets.dailyDeli,
      time: '40 min',
      shopName: 'Daily Deli',
      place: 'Johar Town',
      vote: '4.8',
      titleFood: TitleFood.Deals),
  DesktopFood(
      foodOrder: Assets.riceBowl,
      time: '12 min',
      shopName: 'Rice Bowl',
      place: 'Wapda Town',
      vote: '4.8',
      titleFood: TitleFood.Deals),
  DesktopFood(
      foodOrder: Assets.healthyFood,
      time: '25 min',
      shopName: 'Healthy Food',
      place: 'Grand Town',
      vote: '4.4',
      titleFood: TitleFood.Deals),
  DesktopFood(
      foodOrder: Assets.indonesianFood,
      time: '30 min',
      shopName: 'Indonesian Food',
      place: 'Rolan Town',
      vote: '5',
      titleFood: TitleFood.Deals),
  DesktopFood(
      foodOrder: Assets.coffee,
      time: '15 min',
      shopName: 'Coffee',
      place: 'Mid Town',
      vote: '4.7',
      titleFood: TitleFood.Deals),
  DesktopFood(
      foodOrder: Assets.cake,
      time: '40 min',
      shopName: 'Jean’s Cakes',
      place: 'Johar Town',
      vote: '4.8',
      titleFood: TitleFood.Explore),
  DesktopFood(
      foodOrder: Assets.chocolate,
      time: '20 min',
      shopName: 'Thicc Shakes',
      place: 'Wapda Town',
      vote: '4.5',
      titleFood: TitleFood.Explore),
  DesktopFood(
      foodOrder: Assets.panCake,
      time: '30 min',
      shopName: 'Daily Deli',
      place: 'Garden Town',
      vote: '4.8',
      titleFood: TitleFood.Explore),
  DesktopFood(
      foodOrder: Assets.burger,
      time: '',
      shopName: 'Burger King',
      place: '\$80',
      vote: '',
      titleFood: TitleFood.Recent),
  DesktopFood(
      foodOrder: Assets.crepe,
      time: '',
      shopName: 'Wrap Factory',
      place: '\$30',
      vote: '',
      titleFood: TitleFood.Recent),
];
