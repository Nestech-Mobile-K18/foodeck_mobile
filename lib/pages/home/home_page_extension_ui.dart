part of 'home_page.dart';

class BottomRoute extends StatelessWidget {
  BottomRoute({
    super.key,
    required this.currentIndex,
    required this.homePageBloc,
  });

  final int currentIndex;
  final HomePageBloc homePageBloc;
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
            homePageBloc.add(HomePageSelectIndexEvent(index: value));
            RiveUtils.changeSMITriggerState(
                RiveUtils.bottomModel[value].statusTrigger!);
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
                    icon: SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity: currentIndex == index ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          RiveUtils.bottomModel[index].src,
                          artboard: RiveUtils.bottomModel[index].artBoard,
                          onInit: (artBoard) {
                            RiveUtils.bottomModel[index].statusTrigger =
                                RiveUtils.getRiveTrigger(artBoard,
                                    RiveUtils.bottomModel[index].action,
                                    stateMachineName: RiveUtils
                                        .bottomModel[index].stateMachineName);
                          },
                        ),
                      ),
                    ));
              },
            )
          ]),
    );
  }
}
