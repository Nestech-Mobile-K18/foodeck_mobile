import 'package:template/source/export.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final explorePageBloc = context.read<ExplorePageBloc>();
    return Scaffold(
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
              sharedPreferences.getString('currentAddress') != null
                  ? Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        CustomText(
                            content:
                                sharedPreferences.getString('currentAddress')!)
                      ],
                    )
                  : const SizedBox.shrink(),
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
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 40),
                child: TopListShopping(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: ListSlideBanner(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: MiddleSlideList(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                child: BottomListShopping(),
              )
            ],
          ),
        ),
        floatingActionButton:
            BlocBuilder<RestaurantAddonBloc, RestaurantAddonState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case RestaurantAddonLoadingSuccessState:
                return CartItemsListData.cartItems.isEmpty
                    ? const SizedBox()
                    : Badge(
                        smallSize: 25,
                        largeSize: 25,
                        backgroundColor: Colors.black,
                        label: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: CustomText(
                                content:
                                    '${CartItemsListData.cartItems.length}')),
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
            }
            return const SizedBox();
          },
        ));
  }
}
