import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/deals/deals_item_info.dart';
import 'package:foodeck_app/screens/profile_screen/profile_info.dart';
import 'package:foodeck_app/screens/saved_screen.dart/saved_item_info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  // add or delete saved item when user presses the like button
  void _handleLikeDeal() {
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
        : widget.dealItemInfo.like == false
            ? setState(() {
                savedItems.removeWhere((savedItems) =>
                    savedItems.image == widget.dealItemInfo.image);
              })
            : null;
  }

  //update data on supabase
  final supabase = Supabase.instance.client;
  Future<void> _updateDataSupabase() async {
    final userInfo = await supabase
        .from("user_account")
        .select("id")
        .filter(
          "email",
          "eq",
          profileInfo[0].email.toString(),
        )
        .single();
    final userID = userInfo.entries.single.value;
    //
    final userDeal = await supabase
        .from("deals")
        .select("image")
        .filter(
          "id_user",
          "eq",
          userID,
        )
        .match(
      {"image": widget.dealItemInfo.image.toString()},
    );

    userDeal.isEmpty
        ? await supabase.from("deals").insert({
            "image": widget.dealItemInfo.image.toString(),
            "time": widget.dealItemInfo.time.toString(),
            "title": widget.dealItemInfo.title.toString(),
            "location": widget.dealItemInfo.location.toString(),
            "star": widget.dealItemInfo.star.toString(),
            "like": "true",
            "id_user": userID,
          })
        : await supabase.from("deals").update({
            "like": widget.dealItemInfo.like.toString(),
            "time_updated": DateTime.now().toString(),
          }).match({
            "image": widget.dealItemInfo.image.toString(),
            "id_user": userID,
          });
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

                    _handleLikeDeal();
                    _updateDataSupabase();
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
