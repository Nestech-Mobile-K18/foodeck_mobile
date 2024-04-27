import 'dart:async';

import 'package:flutter/material.dart';
import 'package:template/pages/home/vm/home_view_model.dart';
import 'package:template/widgets/custom_text.dart';

import '../../../resources/const.dart';
import '../../../widgets/loading_indicator.dart';
import '../models/categories_products.dart';

class HomeDeals extends StatefulWidget {
  final void Function(Map<String, dynamic>)? onDealSelected;
  final List<Map<String, dynamic>>? data;
  final VoidCallback? onTapShowListMenu;
  final String? userAddress;
  const HomeDeals(
      {super.key,
      this.onDealSelected,
      this.data,
      this.onTapShowListMenu,
      this.userAddress});

  @override
  State<HomeDeals> createState() => _HomeDealsState();
}

class _HomeDealsState extends State<HomeDeals> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  final currentCard = ValueNotifier(0);
  String? isTime;
  String? distance;
  List<bool> like = [false, false, false, false, false];
  final HomeViewModel _viewModel = HomeViewModel();

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
                      onPressed: widget.onTapShowListMenu,
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
            height: 300,
            child: PageView.builder(
              scrollBehavior: const ScrollBehavior(),
              onPageChanged: (value) {
                currentCard.value = value;
              },
              controller: pageController,
              clipBehavior: Clip.none,
              itemCount: widget.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (widget.onDealSelected != null) {
                      _viewModel
                          .calculateDistanceAndTime(widget.userAddress ?? '',
                              widget.data?[index]['place'])
                          .then((snapshot) {
                        if (snapshot == null) {
                          return null;
                        } else {
                          final dataTime = snapshot['durationInSeconds'];
                          final dataDistance = snapshot['distance'];
                          setState(() {
                            isTime = dataTime.toString();
                            distance = dataDistance.toString();
                          });
                          widget.onDealSelected!({
                            'img_menu': widget.data?[index]['img_menu'],
                            'category': widget.data?[index]['category'],
                            'place': widget.data?[index]['place'],
                            'time': isTime,
                            'vote': widget.data?[index]['vote'],
                            'distance': distance
                          });
                        }
                      });
                    }
                  },
                  child: SingleChildScrollView(
                    child: Column(
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
                                    image: NetworkImage(
                                        widget.data?[index]['img_menu']),
                                    fit: BoxFit.cover,
                                  )),
                              width: 250,
                              height: 160,
                            ),
                          ),
                          FutureBuilder(
                              future: _viewModel.calculateDistanceAndTime(
                                  widget.userAddress ?? '',
                                  widget.data?[index]['place']),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return LoadingIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  final dataTime =
                                      snapshot.data?['durationInSeconds'];
                                  isTime = dataTime.toString();
                                  final dataDistance =
                                      snapshot.data?['distance'];
                                  distance = dataDistance.toString();
                                  return Positioned(
                                    left: 12,
                                    bottom: 12,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        child: Text(dataTime.toString()),
                                      ),
                                    ),
                                  );
                                }
                              }),
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
                                    title: widget.data?[index]['category'],
                                    color: ColorsGlobal.globalBlack,
                                    size: 17,
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            150), // Set maximum width constraint
                                    child: CustomText(
                                      maxLine: 3,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      title: widget.data![index]['place'],
                                      color: ColorsGlobal.textGrey,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                              TextButton.icon(
                                style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.zero)),
                                onPressed: null,
                                label: CustomText(
                                  title: widget.data?[index]['vote'].toString(),
                                  color: ColorsGlobal.globalBlack,
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
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
