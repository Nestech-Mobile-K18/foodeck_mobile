import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "package:foodeck_app/screens/explore_screen/banner/banner_item_info.dart";
import "package:foodeck_app/screens/explore_screen/banner/banner_item_card.dart";
import 'package:foodeck_app/utils/app_colors.dart';

class ListBanner extends StatefulWidget {
  const ListBanner({super.key});

  @override
  State<ListBanner> createState() => _ListBannerState();
}

class _ListBannerState extends State<ListBanner> {
  //
  int currentIndexBanner = 0;
  //
  final CarouselController carouselController = CarouselController();
  //
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 160,
          child: CarouselSlider.builder(
            itemCount: bannerItemInfo.length,
            itemBuilder: (context, index, _) => BannerItemCard(
              bannerItemInfo: bannerItemInfo[index],
            ),
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              aspectRatio: 0.5,
              viewportFraction: 1,
              autoPlayAnimationDuration: const Duration(seconds: 5),
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndexBanner = index;
                });
              },
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerItemInfo.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => carouselController.animateToPage(entry.key),
              child: Container(
                width: currentIndexBanner == entry.key ? 7 : 7,
                height: 7,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColor.grey1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: currentIndexBanner == entry.key
                        ? AppColor.primary
                        : AppColor.white),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
