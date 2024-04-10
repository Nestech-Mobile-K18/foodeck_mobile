import 'package:flutter/material.dart';

import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';

import '../models/location_model.dart';

class LocationCard extends StatefulWidget {
  final int? itemCount;
  final String? nameOfPlace;
  final String? address;
  final Function()? onLongPress;
  const LocationCard(
      {super.key,
      this.nameOfPlace,
      this.address,
      this.itemCount,
      this.onLongPress});

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  final currentCard = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: PageView.builder(
          scrollBehavior: const ScrollBehavior(),
          onPageChanged: (value) {
            currentCard.value = value;
          },
          controller: pageController,
          clipBehavior: Clip.none,
          itemCount: widget.itemCount,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Stack(alignment: Alignment.topRight, children: [
                  GestureDetector(
                    onLongPress: widget.onLongPress,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        width: double.infinity,
                        height: 80,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Image.asset(
                                MediaRes.location,
                                color: ColorsGlobal.globalBlack,
                                height: 30,
                                width: 30,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    title: widget.nameOfPlace,
                                    color: ColorsGlobal.globalBlack,
                                    size: 15,
                                  ),
                                  Flexible(
                                    child: CustomText(
                                      maxLine: 2,
                                      title: widget.address,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      color: ColorsGlobal.globalBlack,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            );
          },
        ),
      ),
    );
  }
}
