import 'package:flutter/material.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';

class CustomSliverBar extends StatelessWidget {
  const CustomSliverBar({
    super.key,
  });

  // phân loại tabs theo danh sách enum
  List<Tab> _buildCategoryTabs() {
    return FoodCategory.values.map((category) {
      return Tab(
        text: category.toString().split('.').last,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 45,
      backgroundColor: Colors.white,
      expandedHeight: 130,
      pinned: true,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
          title: TabBar(
              tabAlignment: TabAlignment.start,
              indicatorColor: globalPink,
              dividerColor: Colors.grey[200],
              labelColor: globalPink,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              labelStyle:
                  inter.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              tabs: _buildCategoryTabs()),
          expandedTitleScale: 1,
          titlePadding: EdgeInsets.zero,
          background: const Padding(
            padding: EdgeInsets.only(bottom: 57, left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [Icon(Icons.star_border), Text('4.8')],
                    ),
                    Column(
                      children: [
                        Icon(Icons.access_time_outlined),
                        Text('40min')
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.location_on_outlined),
                        Text('1.4km')
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
