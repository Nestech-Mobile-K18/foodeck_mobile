import 'package:flutter/material.dart';
import 'package:template/pages/explore/widget/banner_items.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';

class CustomSearchDelegate extends StatefulWidget {
  const CustomSearchDelegate({super.key});

  @override
  State<CustomSearchDelegate> createState() => _CustomSearchDelegateState();
}

class _CustomSearchDelegateState extends State<CustomSearchDelegate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            clipBehavior: Clip.none,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                homeBar,
                fit: BoxFit.cover,
              ),
            ),
            // expandedHeight: 150,
            pinned: true,
            automaticallyImplyLeading: false,
            titleTextStyle: inter.copyWith(fontSize: 17, color: Colors.white),
            titleSpacing: 24,
            title: Container(
                height: 54,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(4, 4),
                          blurRadius: 5,
                          spreadRadius: 1),
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      Image.asset(search, color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'Search...',
                          style: inter.copyWith(
                              color: Colors.grey[400], fontSize: 17),
                        ),
                      )
                    ],
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: ListView.builder(
                    physics: ScrollPhysics(),
                    clipBehavior: Clip.none,
                    itemCount: middleList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) =>
                        BannerItems(
                            paddingImage: const EdgeInsets.only(right: 10),
                            paddingText: const EdgeInsets.only(left: 3),
                            foodImage: middleList[index].foodOrder,
                            deliveryTime: middleList[index].time,
                            shopName: middleList[index].shopName,
                            shopAddress: middleList[index].place,
                            rateStar: middleList[index].vote,
                            action: () {},
                            heartColor: false))),
          )
        ],
      ),
    );
  }
}
