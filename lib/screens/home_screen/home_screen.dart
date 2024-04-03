import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/explore_screen.dart';
import 'package:foodeck_app/screens/explore_screen/my_location.dart';
import 'package:foodeck_app/screens/notification_screen/notification_screen.dart';
import 'package:foodeck_app/screens/profile_screen/profile_info.dart';
import 'package:foodeck_app/screens/profile_screen/profile_screen.dart';
import 'package:foodeck_app/screens/saved_screen.dart/saved_screen.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/utils/app_images.dart';
import 'package:foodeck_app/widgets/custom_bottom_navigation_bar.dart';
import 'package:foodeck_app/widgets/custom_search_bar.dart';

class HomeScreen extends StatefulWidget {
  final int page;

  const HomeScreen({
    super.key,
    required this.page,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //

  int currentIndexPage = 0;
  List pages = const [
    ExploreScreen(),
    SavedScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  //
  final TextEditingController searchController = TextEditingController();
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.page == 1 & 2 & 3
          ? PreferredSize(
              preferredSize: const Size.fromHeight(124),
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColor.primary,
                flexibleSpace: Stack(
                  children: [
                    Image.asset(
                      AppImage.pattern,
                      height: 124,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const MyLocation(),
                          CustomSearchBar(controller: searchController),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: pages[widget.page],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndexPage: widget.page,
        onTap: (index) {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          page: index,
                        )));
            print(profileInfo.length.toString());
          });
        },
      ),
    );
  }
}
