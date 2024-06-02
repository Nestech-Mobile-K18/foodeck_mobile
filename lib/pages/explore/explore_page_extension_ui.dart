part of 'explore_page.dart';

class ExploreBody extends StatelessWidget {
  const ExploreBody({
    super.key,
    required this.successState,
  });

  final ExplorePageLoadingSuccessState successState;

  @override
  Widget build(BuildContext context) {
    final explorePageBloc = context.read<ExplorePageBloc>();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.homeBar), fit: BoxFit.cover))),
            toolbarHeight: 142,
            automaticallyImplyLeading: false,
            titleTextStyle:
                AppText.inter.copyWith(fontSize: 17, color: Colors.white),
            titleSpacing: 24,
            title: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    CustomWidgets.currentAddress(
                        sharedPreferences.getString('currentAddress')!),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: GestureDetector(
                      onTap: () =>
                          explorePageBloc.add(ExplorePageSearchNavigateEvent()),
                      child: Container(
                          height: 54,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(4, 4),
                                    blurRadius: 5,
                                    spreadRadius: 1),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Row(
                              children: [
                                Image.asset(Assets.search, color: Colors.grey),
                                Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: CustomText(
                                        content: 'Search...',
                                        color: Colors.grey[400]))
                              ],
                            ),
                          )),
                    ))
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 40),
                  child: TopListShopping(),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: ListSlideBanner(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: MiddleSlideList(successState: successState),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: BottomListShopping(successState: successState),
                )
              ],
            ),
          ),
          floatingActionButton: Builder(builder: (context) {
            if (CartItemsListData.cartItems.isNotEmpty) {
              return Badge(
                smallSize: 25,
                largeSize: 25,
                backgroundColor: Colors.black,
                label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: CustomText(
                        content: '${CartItemsListData.cartItems.length}')),
                child: FloatingActionButton(
                  onPressed: () {
                    explorePageBloc.add(ExplorePageCartNavigateEvent());
                  },
                  backgroundColor: AppColor.globalPink,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          })),
    );
  }
}
