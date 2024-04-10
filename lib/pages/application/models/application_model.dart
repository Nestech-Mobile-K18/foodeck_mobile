import 'package:flutter/material.dart';

class BottomNavItemModel {
  final IconData iconData;
  final String label;

  BottomNavItemModel({required this.iconData, required this.label});
}

var bottomTabs = [
  BottomNavigationBarItem(
    icon: Icon(Icons.search_outlined),
    label: 'Explore',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.favorite_border_outlined),
    label: 'Saved',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.notifications_none_outlined),
    label: 'Notifications',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_2_outlined),
    label: 'Profile',
  ),
];
