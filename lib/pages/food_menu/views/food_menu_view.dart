import 'package:flutter/material.dart';
import 'package:template/pages/food_menu/vm/food_menu_view_model.dart';
import 'package:template/pages/food_menu/widgets/tab_bar_menu.dart';
import 'package:template/pages/food_menu/widgets/tab_bar_view_menu.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';

import '../../../services/auth_manager.dart';
import '../../../widgets/loading_indicator.dart';

class FoodMenuView extends StatefulWidget {
  final Map<String, dynamic>? bindingData;
  const FoodMenuView({super.key, this.bindingData});

  @override
  State<FoodMenuView> createState() => _FoodMenuViewState();
}

class _FoodMenuViewState extends State<FoodMenuView>
    with TickerProviderStateMixin {
  final FoodMenuViewModel _viewmodel = FoodMenuViewModel();

  Future<List<Map<String, dynamic>>?>? _listFoodsPopular;
  Future<List<Map<String, dynamic>>?>? _listFoodDeals;
  Future<List<Map<String, dynamic>>?>? _listFoodWraps;
  Future<List<Map<String, dynamic>>?>? _listFoodBeverages;
  Future<List<Map<String, dynamic>>?>? _listFoodSandwiches;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _listFoodsPopular =
        _viewmodel.responseMenuPopular(widget.bindingData?['category']);
    _listFoodDeals = _viewmodel.responseMenuDeals();
    _listFoodWraps = _viewmodel.responseMenuWraps();
    _listFoodBeverages = _viewmodel.responseMenuBeverages();
    _listFoodSandwiches = _viewmodel.responseMenuSandwiches();
    _checkIfLiked();
  }

  Future<void> _checkIfLiked() async {
    final userId = await AuthManager.getUserId();
    if (userId != null) {
      final menuIds = await _viewmodel.getListLikeMenuIds(userId);
      setState(() {
        isLiked = menuIds.contains(widget.bindingData?['menu_id']);
      });
    }
  }

  Future<void> _toggleLike() async {
    final userId = await AuthManager.getUserId();
    if (userId != null) {
      if (isLiked) {
        await _viewmodel.requestDeleteIsLike(
            userId, widget.bindingData?['menu_id']);
      } else {
        await _viewmodel.requestUpdateIsLike(widget.bindingData?['menu_id']);
      }
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 5, vsync: this);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Responsive.screenHeight(context) * 0.2),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.bindingData?['img_menu']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 35,
                left: 5,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: ColorsGlobal.globalWhite,
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: widget.bindingData?['category'],
                      size: 22,
                      color: ColorsGlobal.globalWhite,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: Responsive.screenWidth(context) * 0.9,
                      child: CustomText(
                        title: widget.bindingData?['place'],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLine: 2,
                        size: 17,
                        color: ColorsGlobal.globalWhite,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 35,
                right: 20,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.pink : ColorsGlobal.globalWhite,
                      ),
                      onPressed: _toggleLike,
                    ),
                    Icon(
                      Icons.share_outlined,
                      color: ColorsGlobal.globalWhite,
                    ),
                    Icon(
                      Icons.more_vert_outlined,
                      color: ColorsGlobal.globalWhite,
                    ),
                  ],
                )
              ),

            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: Responsive.screenWidth(context),
              height: Responsive.screenHeight(context) * 0.17,
              color: ColorsGlobal.globalWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.star_border_rounded,
                            color: ColorsGlobal.globalBlack,
                            size: 25,
                          ),
                          const SizedBox(height: 5),
                          CustomText(
                            title: widget.bindingData?['vote'].toString(),
                            color: ColorsGlobal.globalBlack,
                            size: 17,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            color: ColorsGlobal.globalBlack,
                            size: 25,
                          ),
                          const SizedBox(height: 5),
                          CustomText(
                            title: widget.bindingData?['time'].toString(),
                            color: ColorsGlobal.globalBlack,
                            size: 17,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: ColorsGlobal.globalBlack,
                            size: 25,
                          ),
                          const SizedBox(height: 5),
                          CustomText(
                            title:
                                '${widget.bindingData?['distance'].toString()} km',
                            color: ColorsGlobal.globalBlack,
                            size: 17,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TabBarMenu(controller: tabController),
                ],
              ),
            ),
            FutureBuilder<List<List<Map<String, dynamic>>?>>(
              future: Future.wait([
                _listFoodsPopular!,
                _listFoodDeals!,
                _listFoodWraps!,
                _listFoodBeverages!,
                _listFoodSandwiches!
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return TabBarViewMenu(
                    controller: tabController,
                    listFoodsPopular: snapshot.data?[0],
                    listFoodDeals: snapshot.data?[1],
                    listFoodWraps: snapshot.data?[2],
                    listFoodBeverages: snapshot.data?[3],
                    listFoodSanwiches: snapshot.data?[4],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
