import 'dart:async';

import 'package:flutter/material.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';
import 'package:template/values/text_styles.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.95);
  double viewportFraction = 0.8;
  double pageOffset = 0;
  final currentCard = ValueNotifier(0);
  late Timer timer;
  bool love = false;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        if (currentCard.value == 2) {
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
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page!;
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                homeBar,
                fit: BoxFit.cover,
              )),
          toolbarHeight: 168,
          automaticallyImplyLeading: false,
          titleTextStyle: inter.copyWith(fontSize: 17, color: Colors.white),
          titleSpacing: 24,
          title: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text('Block B Phase 2 Johar Town, Lahore')
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  style: inter.copyWith(fontSize: 17, color: Colors.grey),
                  decoration: InputDecoration(
                      constraints: BoxConstraints(maxWidth: 328, maxHeight: 54),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none),
                      hintText: 'Search...',
                      hintStyle:
                          inter.copyWith(fontSize: 17, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 8, 16),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Stack(children: [
                    Image.asset(
                      food,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 106,
                      left: 12,
                      bottom: 12,
                      child: RichText(
                          text: TextSpan(
                              text: 'Food\n',
                              style: inter.copyWith(
                                  fontSize: 17, color: Colors.white),
                              children: [
                            TextSpan(
                                text: 'Order food you love',
                                style: inter.copyWith(fontSize: 12))
                          ])),
                    )
                  ]),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, right: 16),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Stack(children: [
                          Image.asset(
                            grocery,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 106,
                            left: 12,
                            bottom: 12,
                            child: RichText(
                                text: TextSpan(
                                    text: 'Grocery\n',
                                    style: inter.copyWith(
                                        fontSize: 17, color: Colors.white),
                                    children: [
                                  TextSpan(
                                      text: 'Shop daily life items',
                                      style: inter.copyWith(fontSize: 12))
                                ])),
                          )
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Stack(children: [
                          Image.asset(
                            desert,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 106,
                            left: 12,
                            bottom: 12,
                            child: RichText(
                                text: TextSpan(
                                    text: 'Deserts\n',
                                    style: inter.copyWith(
                                        fontSize: 17, color: Colors.white),
                                    children: [
                                  TextSpan(
                                      text: 'Something Sweet',
                                      style: inter.copyWith(fontSize: 12))
                                ])),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 16),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        currentCard.value = value;
                      },
                      controller: pageController,
                      clipBehavior: Clip.none,
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(children: [
                          Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Image.asset(
                              pizzaBanner,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 24,
                            top: 26,
                            bottom: 26,
                            child: RichText(
                                text: TextSpan(
                                    text: 'Pizza Party\n',
                                    style: inter.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: [
                                  WidgetSpan(
                                      child: SizedBox(
                                    height: 20,
                                  )),
                                  TextSpan(
                                      text:
                                          'Enjoy pizza from Johnny\nand get up to 30% off\n',
                                      style: inter.copyWith(
                                          fontSize: 12, color: Colors.grey)),
                                  WidgetSpan(
                                      child: SizedBox(
                                    height: 20,
                                  )),
                                  TextSpan(
                                      text: '\nStarting from\n',
                                      style: inter.copyWith(
                                          fontSize: 10, color: Colors.grey)),
                                  TextSpan(
                                      text: '\$10',
                                      style: inter.copyWith(color: globalPink))
                                ])),
                          )
                        ]);
                      },
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: currentCard,
                  builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 155, bottom: 40),
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
                                    ? globalPink
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
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Deals',
                        style: inter.copyWith(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_forward))
                    ],
                  ),
                ),
                SizedBox(
                  width: 240,
                  height: 214,
                  child: PageView.builder(
                    onPageChanged: (value) {},
                    // controller: pageController,
                    clipBehavior: Clip.none,
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Stack(alignment: Alignment.topRight, children: [
                            Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: Image.asset(
                                dailyDeli,
                                fit: BoxFit.cover,
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
                                    '40 min',
                                    style: inter.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    love = !love;
                                  });
                                },
                                icon: Icon(
                                  love ? Icons.favorite : Icons.favorite_border,
                                  color: love ? globalPink : Colors.white,
                                ))
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      text: 'Daily Deli\n',
                                      style: inter.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      children: [
                                    TextSpan(
                                        text: 'Johar Town',
                                        style: inter.copyWith(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal))
                                  ])),
                              TextButton.icon(
                                style: ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.zero)),
                                onPressed: null,
                                label: Text('4.8',
                                    style: inter.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                icon: Icon(
                                  Icons.star,
                                  color: voteYellow,
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Badge(
          smallSize: 22,
          largeSize: 22,
          textStyle: inter.copyWith(fontSize: 17),
          backgroundColor: Colors.black,
          label: Text('4'),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: globalPink,
            shape: CircleBorder(),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
