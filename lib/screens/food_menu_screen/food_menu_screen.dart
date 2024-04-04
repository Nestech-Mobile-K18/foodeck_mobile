import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/deals/deals_item_info.dart';
import 'package:foodeck_app/screens/explore_screen/explore_more/explore_more_item_info.dart';
import 'package:foodeck_app/screens/saved_screen.dart/saved_item_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodMenuScreen extends StatefulWidget {
  final DealsItemInfo? dealsItemInfo;
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
    final newSavedDealItem = SavedItemInfo(
      image: widget.dealsItemInfo!.image,
      time: widget.dealsItemInfo!.time,
      title: widget.dealsItemInfo!.title,
      location: widget.dealsItemInfo!.location,
      star: widget.dealsItemInfo!.star,
    );
    savedDeals == true
        ? setState(() {
            savedItems.add(newSavedDealItem);
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
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
                    colors: [Color.fromRGBO(1, 1, 1, 0.7), Colors.transparent],
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
                Navigator.pop(context);
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
      ),
    );
  }
}
