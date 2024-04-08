import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/deals/deals_item_info.dart';
import 'package:foodeck_app/screens/saved_screen.dart/saved_item_info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodeck_app/utils/app_colors.dart';

class DealsCard extends StatefulWidget {
  final dynamic onTapChooseDeal;
  final bool selectedDeal;
  final DealItemInfo dealItemInfo;

  const DealsCard({
    super.key,
    required this.onTapChooseDeal,
    required this.selectedDeal,
    required this.dealItemInfo,
  });

  @override
  State<DealsCard> createState() => _DealsCardState();
}

class _DealsCardState extends State<DealsCard> {
  //

//
  void _savedItem() {
    final newSavedDealItem = SavedItemInfo(
      image: widget.dealItemInfo.image,
      time: widget.dealItemInfo.time,
      title: widget.dealItemInfo.title,
      location: widget.dealItemInfo.location,
      star: widget.dealItemInfo.star,
      like: true,
    );
    widget.dealItemInfo.like == true
        ? setState(() {
            savedItems.add(newSavedDealItem);
          })
        : null;
  }

  void _unsavedItem() {
    widget.dealItemInfo.like == false
        ? setState(() {
            savedItems.removeWhere(
                (savedItems) => savedItems.title == widget.dealItemInfo.title);
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
          ChoiceChip(
            selected: widget.selectedDeal,
            onSelected: widget.onTapChooseDeal,
            selectedColor: AppColor.primary.withOpacity(0.3),
            side: BorderSide.none,
            padding: EdgeInsets.zero,
            showCheckmark: false,
            label: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: 240,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(widget.dealItemInfo.image),
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
                              widget.dealItemInfo.time,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
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
                                widget.dealItemInfo.title,
                                style: GoogleFonts.inter(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.black,
                                ),
                              ),
                              Text(
                                widget.dealItemInfo.location,
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
                                widget.dealItemInfo.star.toString(),
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
                color: widget.dealItemInfo.like == false
                    ? AppColor.white.withOpacity(0.3)
                    : AppColor.primary.withOpacity(0.3),
              ),
              child: IconButton(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                isSelected: widget.dealItemInfo.like,
                onPressed: () {
                  setState(() {
                    widget.dealItemInfo.like = !widget.dealItemInfo.like;
                    _savedItem();
                    _unsavedItem();
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
    );
  }
}
