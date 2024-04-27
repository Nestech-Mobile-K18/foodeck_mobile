import 'package:flutter/material.dart';

import '../../../resources/const.dart';

class TabBarMenu extends StatefulWidget {
  final TabController? controller;
  const TabBarMenu({super.key, required this.controller});

  @override
  State<TabBarMenu> createState() => _TabBarMenuState();
}

class _TabBarMenuState extends State<TabBarMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.screenHeight(context) * 0.05,
      width: Responsive.screenWidth(context),
      child: TabBar(
        controller: widget.controller,
        labelColor: ColorsGlobal.globalPink,
        indicatorColor: ColorsGlobal.globalPink,
        labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        dividerHeight: 0,
        unselectedLabelColor: Colors.grey,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: const [
          Tab(
            text: 'Popular',
          ),
          Tab(
            text: 'Deals',
          ),
          Tab(
            text: 'Wraps',
          ),
          Tab(
            text: 'Beverages',
          ),
          Tab(
            text: 'Sandwiches',
          ),
        ],
      ),
    );
  }
}
