import 'dart:async';

import 'package:flutter/material.dart';
import 'package:template/widgets/custom_text.dart';

import '../../../resources/const.dart';
import '../models/categories_products.dart';

class HomeDeals extends StatefulWidget {
  const HomeDeals({super.key});

  @override
  State<HomeDeals> createState() => _HomeDealsState();
}

class _HomeDealsState extends State<HomeDeals> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  final currentCard = ValueNotifier(0);

  List<bool> like = [false, false, false, false, false];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                title: StringExtensions.deals,
                size: 17,
                color: ColorsGlobal.globalBlack,
                fontWeight: FontWeight.w700,
              ),
              ValueListenableBuilder(
                valueListenable: currentCard,
                builder: (BuildContext context, int value, Widget? child) {
                  return IconButton(
                      onPressed: () {}, icon: const Icon(Icons.arrow_forward));
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
            width: 270,
            height: 220,
            child: PageView.builder(
              scrollBehavior: const ScrollBehavior(),
              onPageChanged: (value) {
                currentCard.value = value;
              },
              controller: pageController,
              clipBehavior: Clip.none,
              itemCount: deals.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Stack(alignment: Alignment.topRight, children: [
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.red,
                              image: DecorationImage(
                                image: AssetImage(
                                  deals[index].foodBanner,
                                ),
                                fit: BoxFit.cover,
                              )),
                          width: 250,
                          height: 160,
                        ),
                      ),
                      Positioned(
                        left: 12,
                        bottom: 12,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              deals[index].time,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            like[index]
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: like[index]
                                ? ColorsGlobal.globalPink
                                : Colors.white,
                          ))
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: deals[index].foodName,
                                color: ColorsGlobal.globalBlack,
                                size: 17,
                              ),
                              CustomText(
                                title: deals[index].place,
                                color: ColorsGlobal.textGrey,
                                size: 15,
                              ),
                            ],
                          ),
                          TextButton.icon(
                            style: const ButtonStyle(
                                padding:
                                    MaterialStatePropertyAll(EdgeInsets.zero)),
                            onPressed: null,
                            label: Text(
                              deals[index].vote,
                            ),
                            icon: const Icon(
                              Icons.star,
                              color: ColorsGlobal.globalYellow,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
