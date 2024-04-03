import 'package:foodeck_app/utils/app_images.dart';

class BannerItemInfo {
  final String image;
  final String title;
  final String discription;
  final String subtext;
  final String price;

  BannerItemInfo({
    required this.image,
    required this.title,
    required this.discription,
    required this.subtext,
    required this.price,
  });
}

List<BannerItemInfo> bannerItemInfo = [
  BannerItemInfo(
      image: AppImage.pizzaParty,
      title: "Pizza Party",
      discription: "Enjoy pizza from Johnny and get upto 30% off",
      subtext: "Starting from",
      price: "\$10"),
  BannerItemInfo(
      image: AppImage.riceCombo,
      title: "Rice Combo",
      discription: "Enjoy Rice Combo from KFC and get upto 15% off",
      subtext: "Starting from",
      price: "\$15"),
  BannerItemInfo(
      image: AppImage.desertCombo,
      title: "Deserts Combo",
      discription:
          "Enjoy Deserts Combo from Baskin Robbins and get upto 20% off",
      subtext: "Starting from",
      price: "\$5"),
];
