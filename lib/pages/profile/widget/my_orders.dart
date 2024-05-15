import 'package:template/source/export.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.95);
  int currentCard = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dataOrderComplete,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingAnimationRive();
          }
          return Scaffold(
            appBar: AppBar(
                shape: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 8, color: dividerGrey)),
                title: const CustomText(
                    content: 'My Orders', fontWeight: FontWeight.bold)),
            body: SingleChildScrollView(
              child: SizedBox(
                height: 1000,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 290,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.fromLTRB(24, 24, 0, 12),
                              child: CustomText(
                                  content: 'Recent Order',
                                  fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: SizedBox(
                                  width: 300,
                                  child: Consumer<TopFood>(
                                    builder: (BuildContext context,
                                        TopFood drink, Widget? child) {
                                      return PageView.builder(
                                          scrollBehavior:
                                              const ScrollBehavior(),
                                          onPageChanged: (value) {
                                            currentCard = value;
                                          },
                                          controller: pageController,
                                          clipBehavior: Clip.none,
                                          itemCount: drink
                                              .kindFood(
                                                  TitleFood.Recent, desktopFood)
                                              .length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context, int index) => BannerItems(
                                              heartIcon: const SizedBox(),
                                              badge: const SizedBox(),
                                              voteStar: const SizedBox(),
                                              onTap: () {},
                                              paddingImage:
                                                  const EdgeInsets.only(
                                                      right: 10),
                                              paddingText: const EdgeInsets.only(
                                                  left: 3, top: 8),
                                              foodImage: drink
                                                  .kindFood(TitleFood.Recent,
                                                      desktopFood)[index]
                                                  .foodOrder,
                                              deliveryTime: drink
                                                  .kindFood(TitleFood.Recent,
                                                      desktopFood)[index]
                                                  .time,
                                              shopName: drink
                                                  .kindFood(TitleFood.Recent,
                                                      desktopFood)[index]
                                                  .shopName,
                                              shopAddress: drink.kindFood(TitleFood.Recent, desktopFood)[index].place,
                                              rateStar: drink.kindFood(TitleFood.Recent, desktopFood)[index].vote,
                                              action: () {},
                                              iconShape: drink.saveFood.contains(drink.kindFood(TitleFood.Recent, desktopFood)[index]) ? Icons.favorite : Icons.favorite_border,
                                              heartColor: drink.saveFood.contains(drink.kindFood(TitleFood.Recent, desktopFood)[index]) ? globalPink : Colors.white));
                                    },
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(thickness: 8, color: dividerGrey),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRouter.detailHistoryOrder,
                                      arguments: DetailHistoryOrder(
                                          res: snapshot.data![index]));
                                },
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            content: snapshot.data![index]
                                                ['restaurant_name']),
                                        CustomText(
                                            content: snapshot.data![index]
                                                ['date'],
                                            color: Colors.grey,
                                            fontSize: 15)
                                      ]),
                                  trailing: TextButton.icon(
                                    onPressed: null,
                                    label: CustomText(
                                        content:
                                            '\$${snapshot.data![index]['total_price']}',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                    ),
                                    iconAlignment: IconAlignment.end,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Divider(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
