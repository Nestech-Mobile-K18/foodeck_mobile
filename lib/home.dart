import 'package:template/pages/profile/profile_view.dart';

import 'pages/export.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomePage(),
    SaveView(),
    NotificationVew(),
    ProfileView(),
  ];
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsGlobal.globalPink,
        selectedIconTheme:
            IconThemeData(color: ColorsGlobal.globalPink, size: 18.dp),
        unselectedIconTheme: IconThemeData(color: Colors.grey, size: 18.dp),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: ("Explore"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: ("Saved"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: ("Notifications"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: ("Profile"),
          ),
        ],
        onTap: _onTabSelected,
        currentIndex: _selectedIndex,
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: _onTabSelected,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
}
