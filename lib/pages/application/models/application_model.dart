import 'package:flutter/material.dart';

class BottomNavItemModel {
  final IconData iconData;
  final String label;

  BottomNavItemModel({required this.iconData, required this.label});
}

var bottomTabs = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.search_outlined),
    label: 'Explore',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.favorite_border_outlined),
    label: 'Saved',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.notifications_none_outlined),
    label: 'Notifications',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person_2_outlined),
    label: 'Profile',
  ),
];
