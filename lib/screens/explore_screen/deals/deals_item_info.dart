import 'package:foodeck_app/utils/app_images.dart';

class DealsItemInfo {
  final String image;
  final String time;
  final String title;
  final String location;
  final double star;
  DealsItemInfo(
      {required this.image,
      required this.time,
      required this.title,
      required this.location,
      required this.star});
}

List<DealsItemInfo> dealsItemInfo = [
  DealsItemInfo(
      image: AppImage.dailyDeli,
      time: "40 min",
      title: "Daily Deli",
      location: "Johar Town",
      star: 4.8),
  DealsItemInfo(
      image: AppImage.riceBowl,
      time: "12 min",
      title: "Rice Bowl",
      location: "Wapda Town",
      star: 4.3),
  DealsItemInfo(
      image: AppImage.jeanCake,
      time: "40 min",
      title: "Jean's Cakes",
      location: "Johar Town",
      star: 4.8),
  DealsItemInfo(
      image: AppImage.thiccShakes,
      time: "20 min",
      title: "Thicc Shakes",
      location: "Wapda Town",
      star: 4.5),
  DealsItemInfo(
      image: AppImage.dailyDeli2,
      time: "30 min",
      title: "Daily Deli",
      location: "Garden Town",
      star: 4.8),
];
