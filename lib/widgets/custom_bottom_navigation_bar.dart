import 'package:flutter/material.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndexPage;
  final dynamic onTap;
  const CustomBottomNavigationBar(
      {super.key, required this.currentIndexPage, required this.onTap});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  //
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndexPage,
      onTap: widget.onTap,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColor.primary,
      unselectedItemColor: AppColor.grey1,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColor.primary,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColor.grey1,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search_outlined,
            size: 24,
          ),
          label: "Explore",
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline,
              size: 24,
            ),
            label: "Saved"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_outlined,
              size: 24,
            ),
            label: "Notifications"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 24,
            ),
            label: "Profile"),
      ],
    );
  }
}
