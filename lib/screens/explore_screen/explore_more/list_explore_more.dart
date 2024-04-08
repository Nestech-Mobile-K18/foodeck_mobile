import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/explore_more/explore_more_item_card.dart';
import 'package:foodeck_app/screens/explore_screen/explore_more/explore_more_item_info.dart';

class ListExploreMore extends StatefulWidget {
  const ListExploreMore({super.key});

  @override
  State<ListExploreMore> createState() => _ListExploreMoreState();
}

class _ListExploreMoreState extends State<ListExploreMore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      height: 240 * exploreMoreItemInfo.length.toDouble(),
      width: 348,
      child: ListView.builder(
        itemCount: exploreMoreItemInfo.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ExploreMoreItemCard(
          exploreMoreItemInfo: exploreMoreItemInfo[index],
          onTap: () {
            // setState(() {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => FoodMenuScreen(
            //                 dealsItemInfo: null,
            //                 exploreMoreItemInfo: exploreMoreItemInfo[index],
            //               )));
            // });
          },
        ),
      ),
    );
  }
}
