import 'package:flutter/material.dart';
import 'package:template/pages/notification/views/notification_view.dart';
import 'package:template/pages/profile/views/profile_view.dart';
import 'package:template/pages/saved/views/saved_view.dart';

import '../../home/view/home_view.dart';

// ignore: must_be_immutable
class PageBuilder extends StatefulWidget {
  final int index;

  const PageBuilder({
    super.key,
    required this.index,
  });

  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  String? userAddress;
  @override
  Widget build(BuildContext context) {
    return buildPage(widget.index);
  }

  Widget buildPage(int index) {
    List<Widget> widget = [
      HomeView(
        userAddress: (address) {
          userAddress = address;
        },
      ),
      SavedView(userAddress: userAddress),
      const NotificationView(),
      const ProfileView(),
    ];

    return widget[index];
  }
}