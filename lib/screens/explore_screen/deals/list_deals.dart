import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/deals/deals_item_card.dart';
import 'package:foodeck_app/screens/explore_screen/deals/deals_item_info.dart';

class ListDeals extends StatefulWidget {
  const ListDeals({super.key});

  @override
  State<ListDeals> createState() => _ListDealsState();
}

class _ListDealsState extends State<ListDeals> {
  //
  int? selected;

  //
  // void savedDealItem() {
  //   final newSavedDealItem = SavedItemInfo(
  //     image: dealsItemInfo[selected!].image,
  //     time: dealsItemInfo[selected!].time,
  //     title: dealsItemInfo[selected!].title,
  //     location: dealsItemInfo[selected!].location,
  //     star: dealsItemInfo[selected!].star,
  //   );
  //   savedDeals == true
  //       ? setState(() {
  //           savedItems.add(newSavedDealItem);
  //         })
  //       : null;
  // }

  // void unsavedDealItem() {
  //   savedDeals == false
  //       ? setState(() {
  //           savedItems.removeWhere((savedItems) =>
  //               savedItems.title == dealsItemInfo[selected!].title);
  //         })
  //       : null;
  // }

  //
  int? selectedDeal;
  //

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30),
      padding: const EdgeInsets.all(0),
      height: 230,
      width: dealsItemInfo.length.toDouble() * 240,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ListView.builder(
          itemCount: dealsItemInfo.length,
          scrollDirection: Axis.horizontal,
          dragStartBehavior: DragStartBehavior.start,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => DealsItemCard(
            dealsItemInfo: dealsItemInfo[index],
            selectedDeal: selectedDeal == index,
            onTapChooseDeal: (value) {
              setState(() {
                selectedDeal = index;

                print(selectedDeal.toString());
              });
            },

            // ),
          ),
        ),
      ),

      // Wrap(
      //   spacing: 0,
      //   direction: Axis.vertical,
      //   children: List<Widget>.generate(
      //     dealsItemInfo.length,
      //     (int index) {
      // return ChoiceChip(
      //   labelPadding: EdgeInsets.zero,
      //   selected: selected == index,
      //   onSelected: (value) {
      //     selected = index;
      //   },
      //   side: BorderSide.none,
      //   padding: EdgeInsets.zero,
      //   selectedColor: AppColor.primary.withOpacity(0.3),
      //   showCheckmark: false,
      //   label:

      // return DealsItemCard(
      //   dealsItemInfo: dealsItemInfo[index],

      // ),

      //   },
      // ).toList(),
      // ),
      // ),
    );
  }
}
