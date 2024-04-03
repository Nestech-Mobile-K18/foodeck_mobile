import 'package:foodeck_app/utils/app_images.dart';

class ExploreMoreItemInfo {
  final String image;
  final String time;
  final String title;
  final String location;
  final double star;
  ExploreMoreItemInfo(
      {required this.image,
      required this.time,
      required this.title,
      required this.location,
      required this.star});
}

List<ExploreMoreItemInfo> exploreMoreItemInfo = [
  ExploreMoreItemInfo(
      image: AppImage.jeanCake,
      time: "40 min",
      title: "Jean's Cakes",
      location: "Johar Town",
      star: 4.8),
  ExploreMoreItemInfo(
      image: AppImage.thiccShakes,
      time: "20 min",
      title: "Thicc Shakes",
      location: "Wapda Town",
      star: 4.5),
  ExploreMoreItemInfo(
      image: AppImage.dailyDeli2,
      time: "30 min",
      title: "Daily Deli",
      location: "Garden Town",
      star: 4.8),
];
