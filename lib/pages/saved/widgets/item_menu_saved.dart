import 'package:flutter/material.dart';
import 'package:template/pages/saved/vm/saved_view_model.dart';

import '../../../resources/const.dart';
import '../../../services/auth_manager.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/loading_indicator.dart';

class ItemMenuSaved extends StatefulWidget {
  final void Function(Map<String, dynamic>)? onDealSelected;
  final String? userAddress;

  const ItemMenuSaved({
    super.key,
    this.onDealSelected,
    this.userAddress,
  });

  @override
  State<ItemMenuSaved> createState() => _ItemMenuSavedState();
}

class _ItemMenuSavedState extends State<ItemMenuSaved> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  final currentCard = ValueNotifier(0);
  final SavedViewModel _viewModel = SavedViewModel();
  String? isTime;
  String? distance;
  final Future<String?> userId = AuthManager.getUserId();
  int numberOfItems = 0;
  late List<bool> likeStatusList;
  late List<Map<String, dynamic>> _savedMenuData;
  String? currentUserId;
  bool shouldUpdateMenu = false;

  @override
  void initState() {
    super.initState();
    _savedMenuData = [];
    _fetchSavedMenuData();
    _initUserId();
  }

  Future<void> _initUserId() async {
    currentUserId = await userId;
  }

  void _removeItemAt(int index) {
    if (index >= 0 && index < _savedMenuData.length) {
      setState(() {
        _savedMenuData.removeAt(index);
        likeStatusList.removeAt(index);
        numberOfItems = _savedMenuData.length;
      });
    }
  }

  void _fetchSavedMenuData() async {
    final List<Map<String, dynamic>>? savedMenuData =
        await _viewModel.responseListMenuSaved();
    if (savedMenuData != null) {
      // Store menu data into new member variable
      setState(() {
        _savedMenuData = savedMenuData;
        // Initialize likeStatusList with true for each element
        likeStatusList = List.generate(_savedMenuData.length, (index) => true);
        numberOfItems = _savedMenuData.length;
      });
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Center(
        child: _savedMenuData.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: Responsive.blockSizeHeight(context) * 0.5,
                      child: const CustomText(
                        title: 'There are no favorite items yet',
                        color: ColorsGlobal.textGrey,
                        size: 17,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              )
            : Column(
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
                      itemCount: _savedMenuData.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (widget.onDealSelected != null) {
                              _viewModel
                                  .calculateDistanceAndTime(
                                      widget.userAddress ?? '',
                                      _savedMenuData[index]['place'])
                                  .then((snapshot) {
                                final dataTime = snapshot['durationInSeconds'];
                                final dataDistance = snapshot['distance'];
                                setState(() {
                                  isTime = dataTime.toString();
                                  distance = dataDistance.toString();
                                });
                                widget.onDealSelected!({
                                  'user_id': currentUserId,
                                  'menu_id': _savedMenuData[index]['id_menu'],
                                  'img_menu': _savedMenuData[index]['img_menu'],
                                  'category': _savedMenuData[index]['category'],
                                  'place': _savedMenuData[index]['place'],
                                  'time': isTime,
                                  'vote': _savedMenuData[index]['vote'],
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
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.red,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                _savedMenuData[index]
                                                    ['img_menu']),
                                            fit: BoxFit.cover,
                                          )),
                                      width: Responsive.screenWidth(context),
                                      height:
                                          Responsive.blockSizeHeight(context) *
                                              0.3,
                                    ),
                                  ),
                                  FutureBuilder(
                                      future:
                                          _viewModel.calculateDistanceAndTime(
                                              widget.userAddress ?? '',
                                              _savedMenuData[index]['place']),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const LoadingIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          final dataTime = snapshot
                                              .data?['durationInSeconds'];
                                          isTime = dataTime.toString();
                                          final dataDistance =
                                              snapshot.data?['distance'];
                                          distance = dataDistance.toString();
                                          return Positioned(
                                            left: 12,
                                            bottom: 12,
                                            child: Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                child:
                                                    Text(dataTime.toString()),
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
                                            _savedMenuData[index]['id_menu'];

                                        // Check the current status of the menu item
                                        bool currentLikeStatus =
                                            likeStatusList[index];
                                        if (currentLikeStatus == true) {
                                          // If you have already "liked", delete the data of the is_Like column
                                          await _viewModel.requestDeleteIsLike(
                                              currentUserId, menuId);

                                          // Remove item from list
                                          _removeItemAt(index);
                                        }

                                        // Update the state of the "like" icon based on the menu item's new state
                                        setState(() {
                                          if (index >= 0 &&
                                              index < likeStatusList.length) {
                                            likeStatusList[index] =
                                                !currentLikeStatus;
                                          }
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.favorite,
                                        color: ColorsGlobal.globalPink),
                                  )
                                ]),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            title: _savedMenuData[index]
                                                ['category'],
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
                                              title: _savedMenuData[index]
                                                  ['place'],
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
                                          title: _savedMenuData[index]['vote']
                                              .toString(),
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
