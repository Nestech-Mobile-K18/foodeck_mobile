import 'package:flutter/material.dart';
import 'package:template/resources/const.dart';

import '../../../services/auth_manager.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/loading_indicator.dart';
import '../vm/list_menu_view_model.dart';

class ItemMenu extends StatefulWidget {
  final void Function(Map<String, dynamic>)? onDealSelected;
  final String? userAddress;
  final List<Map<String, dynamic>>? data;

  const ItemMenu({
    super.key,
    this.onDealSelected,
    this.userAddress,
    this.data,
  });

  @override
  State<ItemMenu> createState() => _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  final currentCard = ValueNotifier(0);
  String? isTime;
  String? distance;
  late List<bool> likeStatusList;
  final Future<String?> userId = AuthManager.getUserId();
  final ListMenuViewModel _viewModel = ListMenuViewModel();
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
          await _viewModel.getListLikeMenuIds(currentUserId);
      for (int i = 0; i < widget.data!.length; i++) {
        if (likedMenuIds.contains(widget.data![i]['id_menu'])) {
          setState(() {
            likeStatusList[i] = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Responsive.screenWidth(context),
              height: 400,
              child: PageView.builder(
                scrollBehavior: const ScrollBehavior(),
                onPageChanged: (value) {
                  currentCard.value = value;
                },
                controller: pageController,
                clipBehavior: Clip.none,
                itemCount: widget.data!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (widget.onDealSelected != null) {
                        _viewModel
                            .calculateDistanceAndTime(widget.userAddress ?? '',
                                widget.data?[index]['place'])
                            .then((snapshot) {
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
                                width: Responsive.screenWidth(context),
                                height:
                                    Responsive.blockSizeHeight(context) * 0.3,
                              ),
                            ),
                            FutureBuilder(
                                future: _viewModel.calculateDistanceAndTime(
                                    widget.userAddress ?? '',
                                    widget.data?[index]['place']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const LoadingIndicator();
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
                                  String menuId =
                                      widget.data![index]['id_menu'];

                                  // Check the current status of the menu item
                                  bool currentLikeStatus =
                                      likeStatusList[index];
                                  if (currentLikeStatus == true) {
                                    // If you have already "liked", delete the data of the is_Like column
                                    await _viewModel.requestDeleteIsLike(
                                        currentUserId, menuId);
                                  } else if (currentLikeStatus == false) {
                                    // If not "liked", update the is_Like status
                                    await _viewModel
                                        .requestUpdateIsLike(menuId);
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
                                      constraints: const BoxConstraints(
                                          maxWidth:
                                              280), // Set maximum width constraint
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
                                    title:
                                        widget.data![index]['vote'].toString(),
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
            )
          ],
        ),
      ),
    );
  }
}
