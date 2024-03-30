import 'package:template/resources/const.dart';

class SlideProducts {
  final String foodBanner;
  final int isButton;

  SlideProducts(
    this.foodBanner,
    this.isButton,
  );
}

List<SlideProducts> slideProducts = [
  SlideProducts(MediaRes.banner1, 1),
  SlideProducts(MediaRes.banner2, 2),
  SlideProducts(MediaRes.banner3, 3),
];
