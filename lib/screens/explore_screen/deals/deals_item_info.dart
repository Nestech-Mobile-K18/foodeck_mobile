import 'package:foodeck_app/utils/app_images.dart';

class DealItemInfo {
  final String image;
  final String time;
  final String store;
  final String location;
  final double star;
  late bool like;
  DealItemInfo(
      {required this.image,
      required this.time,
      required this.store,
      required this.location,
      required this.star,
      required this.like});
}

List<DealItemInfo> dealsItemInfo = [
  DealItemInfo(
    image: AppImage.dailyDeli,
    time: "40 min",
    store: "Daily Deli",
    location: "Johar Town",
    star: 4.8,
    like: false,
  ),
  DealItemInfo(
    image: AppImage.riceBowl,
    time: "12 min",
    store: "Rice Bowl",
    location: "Wapda Town",
    star: 4.3,
    like: false,
  ),
  DealItemInfo(
    image: AppImage.jeanCake,
    time: "40 min",
    store: "Jean's Cakes",
    location: "Johar Town",
    star: 4.8,
    like: false,
  ),
  DealItemInfo(
    image: AppImage.thiccShakes,
    time: "20 min",
    store: "Thicc Shakes",
    location: "Wapda Town",
    star: 4.5,
    like: false,
  ),
  DealItemInfo(
    image: AppImage.dailyDeli2,
    time: "30 min",
    store: "Daily Deli",
    location: "Garden Town",
    star: 4.8,
    like: false,
  ),
];
