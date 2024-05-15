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
                  bottomModel[value].statusTrigger!);
            },
            currentIndex: currentIndex,
            selectedLabelStyle: AppText.inter.copyWith(fontSize: 11),
            unselectedLabelStyle: AppText.inter.copyWith(fontSize: 11),
            showUnselectedLabels: true,
            unselectedItemColor: globalPink.withOpacity(0.5),
            selectedItemColor: globalPink,
            elevation: 20,
            items: [
              ...List.generate(
                bottomModel.length,
                (index) {
                  return BottomNavigationBarItem(
                      label: bottomModel[index].label,
                      icon: SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity: currentIndex == index ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            bottomModel[index].src,
                            artboard: bottomModel[index].artBoard,
                            onInit: (artBoard) {
                              bottomModel[index].statusTrigger =
                                  RiveUtils.getRiveTrigger(
                                      artBoard, bottomModel[index].action,
                                      stateMachineName:
                                          bottomModel[index].stateMachineName);
                            },
                          ),
                        ),
                      ));
                },
              )
            ]),
        floatingActionButton: context.watch<Restaurant>().cartItems.isEmpty
            ? const SizedBox()
            : Badge(
                smallSize: 25,
                largeSize: 25,
                backgroundColor: Colors.black,
                label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: CustomText(
                        content:
                            '${context.watch<Restaurant>().cartItems.length}')),
                child: FloatingActionButton(
                  onPressed: () {
                    homePageBloc.add(HomePageNavigateEvent());
                  },
                  backgroundColor: globalPink,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ),
              ));
  }
}
