import 'package:flutter/material.dart';
import 'package:template/pages/home/vm/home_view_model.dart';
import 'package:template/widgets/custom_text.dart';

import '../../../resources/const.dart';
import '../../../services/auth_manager.dart';
import '../../../widgets/loading_indicator.dart';
import '../models/categories_products.dart';

class HomeDeals extends StatefulWidget {
  final void Function(Map<String, dynamic>)? onDealSelected;
  final List<Map<String, dynamic>>? data;
  final VoidCallback? onTapShowListMenu;
  final String? userAddress;
  const HomeDeals(
      {Key? key,
      this.onDealSelected,
      this.data,
      this.onTapShowListMenu,
      this.userAddress})
      : super(key: key);

  @override
  State<HomeDeals> createState() => _HomeDealsState();
}

class _HomeDealsState extends State<HomeDeals> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  final currentCard = ValueNotifier(0);
  String? isTime;
  String? distance;
  late List<bool> likeStatusList; // Declare variable likeStatusList
  final Future<String?> userId = AuthManager.getUserId();
  final HomeViewModel _viewModel = HomeViewModel();
  String? currentUserId;

  @override
  void initState() {
    super.initState();

    if (widget.data != null) {
      // Initialize likeStatusList and call getListLikeMenuIds to get the list of liked menus
      likeStatusList = List.filled(widget.data!.length, false);
      _initLikeStatusList();
    }
    _initUserId();
  }

  Future<void> _initUserId() async {
    currentUserId = await userId;
  }

  Future<void> _initLikeStatusList() async {
    String? currentUserId = await userId;
    if (currentUserId != null) {
      List<String> likedMenuIds =
          await _viewModel.getListLikeMenuIds(currentUserId ?? '');
      if (mounted) {
        // Check if the widget is mounted
        setState(() {
          for (int i = 0; i < widget.data!.length; i++) {
            if (mounted) {
              // Double check before calling setState()
              if (likedMenuIds.contains(widget.data![i]['id_menu'])) {
                likeStatusList[i] = true;
              }
            }
          }
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _initLikeStatusList();
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
                              widget.data![index]['place'])
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
                            'user_id': currentUserId,
                            'menu_id': widget.data?[index]['id_menu'],
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
                                        widget.data![index]['img_menu']),
                                    fit: BoxFit.cover,
                                  )),
                              width: 250,
                              height: 160,
                            ),
                          ),
                          FutureBuilder(
                              future: _viewModel.calculateDistanceAndTime(
                                  widget.userAddress ?? '',
                                  widget.data![index]['place']),
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
                            onPressed: () async {
                              String? currentUserId = await userId;
                              if (currentUserId != null) {
                                String menuId = widget.data![index]['id_menu'];

                                // Check the current status of the menu item
                                bool currentLikeStatus = likeStatusList[index];
                                if (currentLikeStatus == true) {
                                  // If you have already "liked", delete the data of the is_Like column
                                  await _viewModel.requestDeleteIsLike(
                                      currentUserId, menuId);
                                } else if (currentLikeStatus == false) {
                                  // If not "liked", update the is_Like status
                                  await _viewModel.requestUpdateIsLike(menuId);
                                }

                                // Update the state of the "like" icon based on the menu item's new state
                                setState(() {
                                  likeStatusList[index] = !currentLikeStatus;
                                });
                              }
                            },
                            icon: Icon(
                              likeStatusList[index]
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: likeStatusList[index]
                                  ? ColorsGlobal.globalPink
                                  : Colors.white,
                            ),
                          )
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
                                    title: widget.data![index]['category'],
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
                                  title: widget.data![index]['vote'].toString(),
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
