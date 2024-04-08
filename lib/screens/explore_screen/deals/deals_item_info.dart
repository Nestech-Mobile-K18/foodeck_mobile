import 'package:foodeck_app/utils/app_images.dart';

class DealItemInfo {
  final String image;
  final String time;
  final String title;
  final String location;
  final double star;
  late bool like;
  DealItemInfo(
      {required this.image,
      required this.time,
      required this.title,
      required this.location,
      required this.star,
      required this.like});
}

List<DealItemInfo> dealsItemInfo = [
  DealItemInfo(
    image: AppImage.dailyDeli,
    time: "40 min",
    title: "Daily Deli",
    location: "Johar Town",
    star: 4.8,
    like: false,
  ),
  DealItemInfo(
    image: AppImage.riceBowl,
    time: "12 min",
    title: "Rice Bowl",
    location: "Wapda Town",
    star: 4.3,
    like: false,
  ),
  DealItemInfo(
    image: AppImage.jeanCake,
    time: "40 min",
    title: "Jean's Cakes",
    location: "Johar Town",
    star: 4.8,
    like: false,
  ),
  DealItemInfo(
    image: AppImage.thiccShakes,
    time: "20 min",
    title: "Thicc Shakes",
    location: "Wapda Town",
    star: 4.5,
    like: false,
  ),
  DealItemInfo(
    image: AppImage.dailyDeli2,
    time: "30 min",
    title: "Daily Deli",
    location: "Garden Town",
    star: 4.8,
    like: false,
  ),
];
