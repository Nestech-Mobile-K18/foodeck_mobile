import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';

import '../../../main.dart';

class MiddleSlideList extends StatefulWidget {
  const MiddleSlideList({
    super.key,
  });

  @override
  State<MiddleSlideList> createState() => _MiddleSlideListState();
}

class _MiddleSlideListState extends State<MiddleSlideList> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.99);
  final currentCard = ValueNotifier(0);

  void getNext() {
    setState(() {
      if (currentCard.value == middleList.length - 1) {
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
  }

  List<bool> like = [false, false, false, false, false];
  void check(int index) {
    setState(() {
      switch (index) {
        case 0:
          like[0] = !like[0];
          like[0] ? saveBanner(index) : deleteBanner(index);
          break;
        case 1:
          like[1] = !like[1];
          like[1] ? saveBanner(index) : deleteBanner(index);
          break;
        case 2:
          like[2] = !like[2];
          like[2] ? saveBanner(index) : deleteBanner(index);
          break;
        case 3:
          like[3] = !like[3];
          like[3] ? saveBanner(index) : deleteBanner(index);
          break;
        case 4:
          like[4] = !like[4];
          like[4] ? saveBanner(index) : deleteBanner(index);
          break;
      }
    });
  }

  Future saveBanner(index) async {
    try {
      await supabase.from('banners').upsert({
        'food': middleList[index].foodOrder,
        'time': middleList[index].time,
        'shop_name': middleList[index].shopName,
        'place': middleList[index].place,
        'vote': middleList[index].vote
      });
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error occurred, please retry')));
    }
  }

  Future deleteBanner(index) async {
    try {
      await supabase.from('banners').delete().match({
        'food': middleList[index].foodOrder,
        'time': middleList[index].time,
        'shop_name': middleList[index].shopName,
        'place': middleList[index].place,
        'vote': middleList[index].vote
      });
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error occurred, please retry')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 25, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Deals',
              style: inter.copyWith(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            ValueListenableBuilder(
              valueListenable: currentCard,
              builder: (BuildContext context, int value, Widget? child) {
                return IconButton(
                    onPressed: () {
                      getNext();
                    },
                    icon: const Icon(Icons.arrow_forward));
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
            itemCount: middleList.length,
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
                                middleList[index].foodOrder,
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
                            middleList[index].time,
                            style: inter.copyWith(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          check(index);
                        },
                        icon: Icon(
                          like[index] ? Icons.favorite : Icons.favorite_border,
                          color: like[index] ? globalPink : Colors.white,
                        ))
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: middleList[index].shopName,
                                style: inter.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: [
                              TextSpan(
                                  text: middleList[index].place,
                                  style: inter.copyWith(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal))
                            ])),
                        TextButton.icon(
                          style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.zero)),
                          onPressed: null,
                          label: Text(middleList[index].vote,
                              style: inter.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          icon: const Icon(
                            Icons.star,
                            color: voteYellow,
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
    ]);
  }
}
