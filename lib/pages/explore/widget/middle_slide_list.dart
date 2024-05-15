import 'package:template/source/export.dart';

class MiddleSlideList extends StatefulWidget {
  const MiddleSlideList({
    super.key,
  });

  @override
  State<MiddleSlideList> createState() => _MiddleSlideListState();
}

class _MiddleSlideListState extends State<MiddleSlideList> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.99);

  int currentCard = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<TopFood>(
        builder: (BuildContext context, TopFood value, Widget? child) {
      Future saveBanner(index) async {
        try {
          await supabase.from('items').insert({
            'food':
                value.kindFood(TitleFood.Deals, desktopFood)[index].foodOrder,
            'shop_name':
                value.kindFood(TitleFood.Deals, desktopFood)[index].shopName,
            'time_delivery':
                value.kindFood(TitleFood.Deals, desktopFood)[index].time,
            'place': value.kindFood(TitleFood.Deals, desktopFood)[index].place,
            'vote': value.kindFood(TitleFood.Deals, desktopFood)[index].vote
          }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  duration: Duration(milliseconds: 1500),
                  backgroundColor: globalPinkShadow,
                  content: Text('You just liked this item'))));
        } on AuthException catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 1500),
              backgroundColor: buttonShadowBlack,
              content: Text(error.message)));
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 1500),
              backgroundColor: buttonShadowBlack,
              content: Text('Error occurred, please retry')));
        }
      }

      Future deleteBanner(index) async {
        try {
          await supabase.from('items').delete().match({
            'food':
                value.kindFood(TitleFood.Deals, desktopFood)[index].foodOrder,
            'shop_name':
                value.kindFood(TitleFood.Deals, desktopFood)[index].shopName,
            'time_delivery':
                value.kindFood(TitleFood.Deals, desktopFood)[index].time,
            'place': value.kindFood(TitleFood.Deals, desktopFood)[index].place,
            'vote': value.kindFood(TitleFood.Deals, desktopFood)[index].vote
          }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  duration: Duration(milliseconds: 1500),
                  backgroundColor: buttonShadowBlack,
                  content: Text('You just unliked this item'))));
        } on AuthException catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 1500),
              backgroundColor: buttonShadowBlack,
              content: Text(error.message)));
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 1500),
              backgroundColor: buttonShadowBlack,
              content: Text('Error occurred, please retry')));
        }
      }

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(content: 'Deals', fontWeight: FontWeight.bold),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_forward))
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
                width: 270,
                height: 220,
                child: PageView.builder(
                    scrollBehavior: const ScrollBehavior(),
                    onPageChanged: (value) {
                      currentCard = value;
                    },
                    controller: pageController,
                    clipBehavior: Clip.none,
                    itemCount:
                        value.kindFood(TitleFood.Deals, desktopFood).length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) =>
                        BannerItems(
                            onTap: () =>
                                Navigator.pushNamed(context, AppRouter.dealPage,
                                    arguments: DealsPage(
                                      desktopFood: value.kindFood(
                                          TitleFood.Deals, desktopFood)[index],
                                    )),
                            paddingImage: const EdgeInsets.only(right: 10),
                            paddingText: const EdgeInsets.only(left: 3),
                            foodImage: value
                                .kindFood(TitleFood.Deals, desktopFood)[index]
                                .foodOrder,
                            deliveryTime: value
                                .kindFood(TitleFood.Deals, desktopFood)[index]
                                .time,
                            shopName: value
                                .kindFood(TitleFood.Deals, desktopFood)[index]
                                .shopName,
                            shopAddress: value
                                .kindFood(TitleFood.Deals, desktopFood)[index]
                                .place,
                            rateStar: value
                                .kindFood(TitleFood.Deals, desktopFood)[index]
                                .vote,
                            action: () {
                              if (!value.saveFood.contains(value.kindFood(
                                  TitleFood.Deals, desktopFood)[index])) {
                                value.addToList(value.kindFood(
                                    TitleFood.Deals, desktopFood)[index]);
                                saveBanner(index);
                              } else {
                                value.removeFromList(value.kindFood(
                                    TitleFood.Deals, desktopFood)[index]);
                                deleteBanner(index);
                              }
                            },
                            iconShape: value.saveFood.contains(value.kindFood(
                                    TitleFood.Deals, desktopFood)[index])
                                ? Icons.favorite
                                : Icons.favorite_border,
                            heartColor: value.saveFood.contains(value.kindFood(
                                    TitleFood.Deals, desktopFood)[index])
                                ? globalPink
                                : Colors.white))))
      ]);
    });
  }
}
