import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/deals/deals_item_info.dart';
import 'package:foodeck_app/screens/saved_screen.dart/saved_item_info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodeck_app/utils/app_colors.dart';

class DealsItemCard extends StatefulWidget {
  final DealsItemInfo dealsItemInfo;

  const DealsItemCard({
    super.key,
    required this.dealsItemInfo,
  });

  @override
  State<DealsItemCard> createState() => _DealsItemCardState();
}

class _DealsItemCardState extends State<DealsItemCard> {
  //
  bool savedDeals = false;
//
  void savedDealItem() {
    final newSavedDealItem = SavedItemInfo(
      image: widget.dealsItemInfo.image,
      time: widget.dealsItemInfo.time,
      title: widget.dealsItemInfo.title,
      location: widget.dealsItemInfo.location,
      star: widget.dealsItemInfo.star,
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
            savedItems.removeWhere(
                (savedItems) => savedItems.title == widget.dealsItemInfo.title);
          })
        : null;
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: 240,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(widget.dealsItemInfo.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 20, top: 120),
                      width: 57,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColor.white,
                      ),
                      child: Text(
                        widget.dealsItemInfo.time,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        alignment: Alignment.center,
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: savedDeals == false
                              ? AppColor.white.withOpacity(0.3)
                              : AppColor.primary.withOpacity(0.3),
                        ),
                        child: IconButton(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          isSelected: savedDeals,
                          onPressed: () {
                            setState(() {
                              savedDeals = !savedDeals;
                              savedDealItem();
                              unsavedDealItem();
                            });
                          },
                          icon: Icon(
                            Icons.favorite_outline,
                            size: 15,
                            color: AppColor.white,
                          ),
                          selectedIcon: Icon(
                            Icons.favorite,
                            size: 15,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 5,
                ),
                width: 240,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.dealsItemInfo.title,
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColor.black,
                          ),
                        ),
                        Text(
                          widget.dealsItemInfo.location,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColor.grey2,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color: AppColor.yellow,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.dealsItemInfo.star.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColor.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
