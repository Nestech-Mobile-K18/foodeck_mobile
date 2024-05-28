import 'package:flutter/material.dart';

import '../../../resources/const.dart';
import '../../../widgets/custom_text.dart';
import '../models/categories_products.dart';

class HomeExplore extends StatefulWidget {
  const HomeExplore({super.key});

  @override
  State<HomeExplore> createState() => _HomeExploreState();
}

class _HomeExploreState extends State<HomeExplore> {
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
                title: StringExtensions.exploreMore,
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
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SizedBox(
            height: 750,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              itemCount: categoriesProducts.length,
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
                                  categoriesProducts[index].foodBanner,
                                ),
                                fit: BoxFit.cover,
                              )),
                          width: double.infinity,
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
                              categoriesProducts[index].time,
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
                                title: categoriesProducts[index].foodName,
                                color: ColorsGlobal.globalBlack,
                                size: 17,
                              ),
                              CustomText(
                                title: categoriesProducts[index].place,
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
                              categoriesProducts[index].vote,
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
