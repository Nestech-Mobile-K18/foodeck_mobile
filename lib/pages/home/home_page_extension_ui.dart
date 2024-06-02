part of 'home_page.dart';

class BottomRoute extends StatelessWidget {
  BottomRoute({super.key, required this.currentIndex});

  final int currentIndex;

  final tabs = [
    const ExplorePage(),
    const SavedPage(),
    const NotificationsPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            context
                .read<HomePageBloc>()
                .add(HomePageSelectIndexEvent(index: value));
          },
          currentIndex: currentIndex,
          selectedLabelStyle: AppText.inter.copyWith(fontSize: 11),
          unselectedLabelStyle: AppText.inter.copyWith(fontSize: 11),
          showUnselectedLabels: true,
          unselectedItemColor: AppColor.globalPink.withOpacity(0.5),
          selectedItemColor: AppColor.globalPink,
          elevation: 20,
          items: [
            ...List.generate(
              RiveUtils.bottomModel.length,
              (index) {
                return BottomNavigationBarItem(
                    label: RiveUtils.bottomModel[index].label,
                    icon: RiveAnimations.bottomAnimation(currentIndex, index));
              },
            )
          ]),
    );
  }
}
