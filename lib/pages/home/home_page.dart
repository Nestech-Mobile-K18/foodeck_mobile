import 'package:flutter/material.dart';
import 'package:template/pages/explore/explore_page.dart';
import 'package:template/pages/notifications/notifications_page.dart';
import 'package:template/pages/profile/profile_page.dart';
import 'package:template/pages/saved/saved_page.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tabs = [
    const ExplorePage(),
    const SavedPage(),
    const NotificationsPage(),
    const ProfilePage()
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          currentIndex: currentIndex,
          selectedLabelStyle: inter.copyWith(fontSize: 11),
          unselectedLabelStyle: inter.copyWith(fontSize: 11),
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          selectedItemColor: globalPink,
          elevation: 20,
          selectedIconTheme: const IconThemeData(color: globalPink),
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          items: const [
            BottomNavigationBarItem(label: 'Explore', icon: Icon(Icons.search)),
            BottomNavigationBarItem(
                label: 'Saved', icon: Icon(Icons.favorite_border)),
            BottomNavigationBarItem(
                label: 'Notifications', icon: Icon(Icons.notifications_none)),
            BottomNavigationBarItem(
                label: 'Profile', icon: Icon(Icons.person_outline_rounded)),
          ]),
    );
  }
}
