import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/deals/deals_item_info.dart';
import 'package:foodeck_app/screens/explore_screen/explore_more/explore_more_item_info.dart';
import 'package:foodeck_app/screens/home_screen/home_screen.dart';
import 'package:foodeck_app/screens/profile_screen/profile_info.dart';
import 'package:foodeck_app/screens/saved_screen.dart/saved_item_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SavedItemCard extends StatefulWidget {
  final ExploreMoreItemInfo? exploreMoreItemInfo;
  final DealItemInfo? dealsItemInfo;
  final SavedItemInfo savedItems;

  const SavedItemCard({
    super.key,
    required this.savedItems,
    this.exploreMoreItemInfo,
    this.dealsItemInfo,
  });

  @override
  State<SavedItemCard> createState() => _SavedItemCardState();
}

class _SavedItemCardState extends State<SavedItemCard> {
  //
  bool savedItem = true;
  //
  int currentIndexPage = 1;
  //delete saved item when user unchecks the like button
  void _unsavedDealItem() {
    savedItem == false
        ? setState(() {
            savedItems.removeWhere(
                (savedItems) => savedItems.store == widget.savedItems.store);
            //
            dealsItemInfo[dealsItemInfo.indexWhere((dealsItemInfo) =>
                    dealsItemInfo.store.contains(widget.savedItems.store))]
                .like = false;
            //
            exploreMoreItemInfo[exploreMoreItemInfo.indexWhere(
                    (exploreMoreItemInfo) => exploreMoreItemInfo.title
                        .contains(widget.savedItems.store))]
                .like = false;
          })
        : null;
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const HomeScreen(page: 1);
      },
    ));
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
    await supabase.from("deals").delete().match({
      "image": widget.savedItems.image.toString(),
      "user_id": userID,
    });

    await supabase.from("explore_more").delete().match({
      "user_id": userID.toString(),
      "image": widget.savedItems.image.toString()
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
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
                image: AssetImage(widget.savedItems.image),
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
                    widget.savedItems.time,
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
                      color: savedItem == false
                          ? AppColor.white.withOpacity(0.3)
                          : AppColor.primary.withOpacity(0.3),
                    ),
                    child: IconButton(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      isSelected: savedItem,
                      onPressed: () {
                        setState(() {
                          savedItem = !savedItem;

                          _unsavedDealItem();
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
            width: 240,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.savedItems.store,
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                    ),
                    Text(
                      widget.savedItems.location,
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
                      widget.savedItems.star.toString(),
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
    );
  }
}
