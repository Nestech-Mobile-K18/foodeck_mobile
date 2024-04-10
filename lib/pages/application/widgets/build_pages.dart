import 'package:flutter/material.dart';
import 'package:template/pages/profile/views/profile_view.dart';

import '../../home/view/home_view.dart';

class PageBuilder extends StatelessWidget {
  final int index;

  const PageBuilder({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildPage(index);
  }

  Widget buildPage(int index) {
    List<Widget> _widget = [
      const HomeView(),
      const ProfileView(),
      Container(),
      Container(),
    ];

    return _widget[index];
  }
}
