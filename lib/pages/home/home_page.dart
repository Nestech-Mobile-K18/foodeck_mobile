import 'package:flutter/material.dart';
import 'package:template/pages/explore/explore_page.dart';
import 'package:template/pages/notifications/notifications_page.dart';
import 'package:template/pages/profile/profile_page.dart';
import 'package:template/pages/saved/saved_page.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/text_styles.dart';

import '../../main.dart';

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
              BottomNavigationBarItem(
                  label: 'Explore', icon: Icon(Icons.search)),
              BottomNavigationBarItem(
                  label: 'Saved', icon: Icon(Icons.favorite_border)),
              BottomNavigationBarItem(
                  label: 'Notifications', icon: Icon(Icons.notifications_none)),
              BottomNavigationBarItem(
                  label: 'Profile', icon: Icon(Icons.person_outline_rounded)),
            ]),
        floatingActionButton: StreamBuilder(
          stream: data,
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            return snapshot.data!.isEmpty
                ? const SizedBox()
                : currentIndex > 0
                    ? const SizedBox()
                    : Badge(
                        smallSize: 22,
                        largeSize: 22,
                        textStyle: inter.copyWith(fontSize: 17),
                        backgroundColor: Colors.black,
                        label: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 1),
                          child: Text('${snapshot.data!.length}',
                              style: inter.copyWith(fontSize: 17)),
                        ),
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              if (currentIndex < 1) {
                                currentIndex = currentIndex + 1;
                              }
                              null;
                            });
                          },
                          backgroundColor: globalPink,
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        ),
                      );
          },
        ));
  }
}
