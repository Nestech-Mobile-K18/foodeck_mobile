import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/explore_more/explore_more_item_info.dart';
import 'package:foodeck_app/screens/profile_screen/profile_info.dart';
import 'package:foodeck_app/screens/saved_screen.dart/saved_item_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExploreMoreItemCard extends StatefulWidget {
  final ExploreMoreItemInfo exploreMoreItemInfo;
  final dynamic onTap;
  const ExploreMoreItemCard(
      {super.key, required this.exploreMoreItemInfo, this.onTap});

  @override
  State<ExploreMoreItemCard> createState() => _ExploreMoreItemCardState();
}

class _ExploreMoreItemCardState extends State<ExploreMoreItemCard> {
  //
  // add or delete saved item when user presses the like button
  void _handleLikeDeal() {
    final newSavedDealItem = SavedItemInfo(
      image: widget.exploreMoreItemInfo.image,
      time: widget.exploreMoreItemInfo.time,
      title: widget.exploreMoreItemInfo.title,
      location: widget.exploreMoreItemInfo.location,
      star: widget.exploreMoreItemInfo.star,
      like: true,
    );
    widget.exploreMoreItemInfo.like == true
        ? setState(() {
            savedItems.add(newSavedDealItem);
          })
        : widget.exploreMoreItemInfo.like == false
            ? setState(() {
                savedItems.removeWhere((savedItems) =>
                    savedItems.image == widget.exploreMoreItemInfo.image);
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
        .from("explore_more")
        .select("image")
        .filter(
          "user_id",
          "eq",
          userID,
        )
        .match(
      {"image": widget.exploreMoreItemInfo.image.toString()},
    );

    userDeal.isEmpty
        ? await supabase.from("explore_more").insert({
            "image": widget.exploreMoreItemInfo.image.toString(),
            "time": widget.exploreMoreItemInfo.time.toString(),
            "title": widget.exploreMoreItemInfo.title.toString(),
            "location": widget.exploreMoreItemInfo.location.toString(),
            "star": widget.exploreMoreItemInfo.star.toString(),
            "like": "true",
            "user_id": userID,
          })
        : await supabase.from("explore_more").update({
            "like": widget.exploreMoreItemInfo.like.toString(),
            "time_updated": DateTime.now().toString(),
          }).match({
            "image": widget.exploreMoreItemInfo.image.toString(),
            "user_id": userID,
          });
  }

  //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 210,
        width: 328,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: 328,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(widget.exploreMoreItemInfo.image),
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
                      widget.exploreMoreItemInfo.time,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      alignment: Alignment.center,
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.exploreMoreItemInfo.like == false
                            ? AppColor.white.withOpacity(0.3)
                            : AppColor.primary.withOpacity(0.3),
                      ),
                      child: IconButton(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        isSelected: widget.exploreMoreItemInfo.like,
                        onPressed: () {
                          setState(() {
                            widget.exploreMoreItemInfo.like =
                                !widget.exploreMoreItemInfo.like;
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
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 5,
              ),
              width: 328,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.exploreMoreItemInfo.title,
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                      ),
                      Text(
                        widget.exploreMoreItemInfo.location,
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
                        widget.exploreMoreItemInfo.star.toString(),
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
      ),
    );
  }
}
