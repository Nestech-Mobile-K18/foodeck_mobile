import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined, color: _getColor(0)),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined, color: _getColor(1)),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined, color: _getColor(2)),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, color: _getColor(3)),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(color: Colors.pink),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        showUnselectedLabels: true,
      ),
    );
  }

  // Function returns the color of the icon based on the tab index
  Color _getColor(int index) {
    return selectedIndex == index ? Colors.pink : Colors.grey;
  }
}
