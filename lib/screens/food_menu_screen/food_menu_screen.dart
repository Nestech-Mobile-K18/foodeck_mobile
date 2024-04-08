import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/deals/deals_item_info.dart';
import 'package:foodeck_app/screens/explore_screen/explore_more/explore_more_item_info.dart';
import 'package:foodeck_app/screens/food_menu_screen/beverages_tab/beverages_tab.dart';
import 'package:foodeck_app/screens/food_menu_screen/deals_tab/deals_tab.dart';
import 'package:foodeck_app/screens/food_menu_screen/populars_tab/populars_tab.dart';
import 'package:foodeck_app/screens/food_menu_screen/sandwiches_tab/sandwiches_tab.dart';
import 'package:foodeck_app/screens/food_menu_screen/wraps_tab/wraps_tab.dart';
import 'package:foodeck_app/screens/home_screen/home_screen.dart';
import 'package:foodeck_app/screens/saved_screen.dart/saved_item_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodMenuScreen extends StatefulWidget {
  final DealItemInfo? dealsItemInfo;
  final ExploreMoreItemInfo? exploreMoreItemInfo;
  const FoodMenuScreen(
      {super.key,
      required this.dealsItemInfo,
      required this.exploreMoreItemInfo});

  @override
  State<FoodMenuScreen> createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  bool savedDeals = false;
//
  void savedDealItem() {
    final newSavedDealItem = DealItemInfo(
      image: widget.dealsItemInfo!.image,
      time: widget.dealsItemInfo!.time,
      title: widget.dealsItemInfo!.title,
      location: widget.dealsItemInfo!.location,
      star: widget.dealsItemInfo!.star,
      like: false,
    );
    savedDeals == true
        ? setState(() {
            dealsItemInfo.add(newSavedDealItem);
          })
        : null;
  }

  void unsavedDealItem() {
    savedDeals == false
        ? setState(() {
            savedItems.removeWhere((savedItems) =>
                savedItems.title == widget.dealsItemInfo!.title);
          })
        : null;
  }

  //

  ///
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(326),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBar(
                elevation: 0,
                flexibleSpace: Stack(
                  children: [
                    Image.asset(
                      widget.dealsItemInfo != null
                          ? widget.dealsItemInfo!.image
                          : widget.exploreMoreItemInfo != null
                              ? widget.exploreMoreItemInfo!.image
                              : "",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(1, 1, 1, 0.7),
                            Colors.transparent
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.2, 1],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 21,
                      left: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.dealsItemInfo != null
                                ? widget.dealsItemInfo!.title
                                : widget.exploreMoreItemInfo != null
                                    ? widget.exploreMoreItemInfo!.title
                                    : "",
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColor.white,
                            ),
                          ),
                          Text(
                            widget.dealsItemInfo != null
                                ? widget.dealsItemInfo!.location
                                : widget.exploreMoreItemInfo != null
                                    ? widget.exploreMoreItemInfo!.location
                                    : "",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                leading: BackButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen(page: 0)));
                    });
                  },
                  color: AppColor.white,
                ),
                actions: [
                  IconButton(
                    alignment: Alignment.center,
                    isSelected: savedDeals,
                    onPressed: () {
                      savedDeals = !savedDeals;
                      savedDealItem();
                      unsavedDealItem();
                    },
                    icon: Icon(
                      Icons.favorite_outline,
                      size: 22,
                      color: AppColor.white,
                    ),
                    selectedIcon: Icon(
                      Icons.favorite,
                      size: 22,
                      color: AppColor.primary,
                    ),
                  ),
                  IconButton(
                    alignment: Alignment.center,
                    onPressed: () {},
                    icon: Icon(
                      Icons.share_outlined,
                      size: 22,
                      color: AppColor.white,
                    ),
                  ),
                  IconButton(
                    alignment: Alignment.center,
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert_outlined,
                      size: 22,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 23,
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_outline,
                        size: 24,
                        color: AppColor.black,
                      ),
                      Text(
                        widget.dealsItemInfo != null
                            ? widget.dealsItemInfo!.star.toString()
                            : widget.exploreMoreItemInfo != null
                                ? widget.exploreMoreItemInfo!.star.toString()
                                : "",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 24,
                        color: AppColor.black,
                      ),
                      Text(
                        widget.dealsItemInfo != null
                            ? widget.dealsItemInfo!.time
                            : widget.exploreMoreItemInfo != null
                                ? widget.exploreMoreItemInfo!.time
                                : "",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 24,
                        color: AppColor.black,
                      ),
                      Text(
                        "1.4km",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
                width: double.infinity,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 600,
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    labelColor: AppColor.primary,
                    unselectedLabelColor: AppColor.grey1,
                    labelStyle: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                    indicatorColor: AppColor.primary,
                    indicatorPadding: EdgeInsets.zero,
                    dividerColor: AppColor.white,
                    tabs: const [
                      Tab(
                        text: "Poppulars",
                      ),
                      Tab(
                        text: "Deals",
                      ),
                      Tab(
                        text: "Wraps",
                      ),
                      Tab(
                        text: "Beverages",
                      ),
                      Tab(
                        text: "Sandwiches",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: TabBarView(
              children: [
                PoppularsTab(
                    location:
                        "${widget.dealsItemInfo!.title}-${widget.dealsItemInfo!.location}"),
                DealsTab(
                    location:
                        "${widget.dealsItemInfo!.title}-${widget.dealsItemInfo!.location}"),
                const WrapsTab(),
                const BeveragesTab(),
                const SandwichesTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
