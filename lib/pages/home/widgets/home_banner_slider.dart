import 'dart:async';

import 'package:flutter/material.dart';
import 'package:template/resources/const.dart';

import '../models/slider_products.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({super.key});

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  final currentCard = ValueNotifier(0);
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        if (currentCard.value == slideProducts.length - 1) {
          currentCard.value = 0;
        } else {
          currentCard.value = currentCard.value + 1;
        }
        pageController.animateToPage(
          currentCard.value,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 170,
          child: PageView.builder(
            onPageChanged: (value) {
              currentCard.value = value;
            },
            controller: pageController,
            clipBehavior: Clip.none,
            itemCount: slideProducts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Stack(clipBehavior: Clip.none, children: [
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                              image:
                                  AssetImage(slideProducts[index].foodBanner),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  if (slideProducts[index].isButton == 1)
                    Positioned(
                      bottom: 15,
                      left: 25,
                      child: Container(
                        height: 30,
                        width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: ColorsGlobal.globalPink),
                        child: const Center(
                          child: Text(
                            StringExtensions.code,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, color: ColorsGlobal.globalWhite),
                          ),
                        ),
                      ),
                    ),
                  if (slideProducts[index].isButton == 3)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 10,
                      child: Center(
                        child: Container(
                          height: 30,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: ColorsGlobal.globalShadowBlack),
                          child: const Center(
                            child: Text(
                              StringExtensions.showNow,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: ColorsGlobal.globalWhite),
                            ),
                          ),
                        ),
                      ),
                    ),
                ]),
              );
            },
          ),
        ),
      ),
      ValueListenableBuilder(
        valueListenable: currentCard,
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.only(left: 175),
            child: Row(
              children: List<Widget>.generate(
                3,
                (indexSlide) => AnimatedContainer(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: indexSlide == value
                          ? ColorsGlobal.globalPink
                          : Colors.white,
                      border: indexSlide == value
                          ? null
                          : Border.all(color: Colors.grey)),
                  duration: const Duration(milliseconds: 350),
                ),
              ),
            ),
          );
        },
      )
    ]);
  }
}
