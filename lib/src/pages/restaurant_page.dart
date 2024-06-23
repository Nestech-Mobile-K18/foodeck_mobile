import 'package:template/src/pages/export.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage(
      {Key? key,
      required this.id,
      required this.nameRestaurant,
      required this.nameAddress,
      required this.rate,
      required this.time,
      required this.timeUnit,
      required this.distance,
      required this.disUnit,
      this.image})
      : super(key: key);
  final int id;
  final String nameRestaurant;
  final String nameAddress;
  final double rate;
  final int time;
  final String timeUnit;
  final double distance;
  final String disUnit;
  final String? image;

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  late final RestaurantInfo retaurant;

  @override
  void initState() {
    // api get info restaurant
    retaurant = RestaurantInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarRestaurant(
            title: widget.nameRestaurant,
            isFavourite: false,
            address: widget.nameAddress,
            imageRestaurant: widget.image!,
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p40, vertical: AppPadding.p12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.favorite_outline_outlined),
                          Text(widget.rate.toString(),
                              style: AppTextStyle.content)
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.access_time_rounded),
                          Text(
                            '${widget.time}${widget.timeUnit}',
                            style: AppTextStyle.content,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          Text('${widget.distance}${widget.disUnit}',
                              style: AppTextStyle.content)
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ScrollableListTabScroller(
                    itemCount: dataRestaurant.length,
                    tabBuilder:
                        (BuildContext context, int index, bool active) =>
                            Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p24),
                      child: Text(
                        dataRestaurant.keys.elementAt(index),
                        style: !active ? null : AppTextStyle.textPinkBold,
                      ),
                    ),
                    itemBuilder: (BuildContext context, int index) => Column(
                      children: [
                        Text(
                          dataRestaurant.keys.elementAt(index),
                          style: AppTextStyle.title,
                        ),
                        ...dataRestaurant.values
                            .elementAt(index)
                            .asMap()
                            .map(
                              (index, value) => MapEntry(index, value),
                            )
                            .values
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
