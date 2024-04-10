import 'package:template/resources/const.dart';

class CategoriesProducts {
  final String foodBanner;
  final String time;
  final String foodName;
  final String place;
  final String vote;

  CategoriesProducts(
      this.foodBanner, this.time, this.foodName, this.place, this.vote);
}

List<CategoriesProducts> deals = [
  CategoriesProducts(
      MediaRes.dailyDeli, '40 min', 'Daily Deli', 'Johar Town', '4.8'),
  CategoriesProducts(
      MediaRes.riceBowl, '12 min', 'Rice Bowl', 'Wapda Town', '4.8'),
];

List<CategoriesProducts> categoriesProducts = [
  CategoriesProducts(
      MediaRes.cakes, '40 min', 'Jean’s Cakes', 'Johar Town', '4.8'),
  CategoriesProducts(
      MediaRes.shakes, '20 min', 'Thicc Shakes', 'Wapda Town', '4.5'),
  CategoriesProducts(
      MediaRes.deli, '30 min', 'Daily Deli', 'Garden Town', '4.5'),
];
