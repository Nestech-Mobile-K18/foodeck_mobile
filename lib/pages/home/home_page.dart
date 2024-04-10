import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/models/desktop_food.dart';
import 'package:template/pages/explore/explore_page.dart';
import 'package:template/pages/notifications/notifications_page.dart';
import 'package:template/pages/profile/profile_page.dart';
import 'package:template/pages/saved/saved_page.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';
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
    return Consumer<TopFood>(
      builder: (BuildContext context, TopFood value, Widget? child) => Scaffold(
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
              unselectedItemColor: Colors.grey[400],
              selectedItemColor: globalPink,
              elevation: 20,
              items: [
                BottomNavigationBarItem(
                    label: 'Explore',
                    icon: Image.asset(
                      search,
                      color: currentIndex == 0 ? Colors.pink : Colors.grey,
                    )),
                BottomNavigationBarItem(
                    label: 'Saved',
                    icon: Badge(
                      backgroundColor:
                          value.saveFood.isEmpty || currentIndex == 1
                              ? Colors.transparent
                              : globalPink,
                      child: Image.asset(
                        heart,
                        color: currentIndex == 1 ? Colors.pink : Colors.grey,
                      ),
                    )),
                BottomNavigationBarItem(
                    label: 'Notifications',
                    icon: Image.asset(
                      bell,
                      color: currentIndex == 2 ? Colors.pink : Colors.grey,
                    )),
                BottomNavigationBarItem(
                    label: 'Profile',
                    icon: Image.asset(
                      user,
                      color: currentIndex == 3 ? Colors.pink : Colors.grey,
                    )),
              ]),
          floatingActionButton: value.saveFood.isEmpty || currentIndex >= 1
              ? SizedBox()
              : Badge(
                  smallSize: 22,
                  largeSize: 22,
                  textStyle: inter.copyWith(fontSize: 17),
                  backgroundColor: Colors.black,
                  label: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                    child: Text('${value.saveFood.length}',
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
                )),
    );
  }
}
