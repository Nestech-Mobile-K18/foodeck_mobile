

import 'export.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ExplorePage(),
    const SavePage(),
    const NotificationPage(),
    const ProfilePage(),
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
            IconThemeData(color: ColorsGlobal.globalPink, size: AppSize.s18),
        unselectedIconTheme: IconThemeData(color: ColorsGlobal.grey, size: AppSize.s18),
        unselectedItemColor: ColorsGlobal.grey,
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
    );
  }
}
