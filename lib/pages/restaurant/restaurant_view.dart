import 'package:flutter/material.dart';
import 'package:template/pages/export.dart';
import 'package:template/pages/restaurant/model.dart';

class RestaurantView extends StatefulWidget {
  const RestaurantView({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _RestaurantViewState createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  late final RestaurantInfo retaurant;

  @override
  void initState() {
    // api get info restaurant
    retaurant = const RestaurantInfo(
        '1', MediaRes.img5, 'Jean’s Cakes', 'Johar Town', true, 4.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarRestaurant(
            title: retaurant.name,
            isFavourite: retaurant.isFavourite,
            address: retaurant.address,
            imageRestaurant: retaurant.image,
          ),


          SliverFillRemaining(child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 40.dp, vertical: 12.dp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Icon(Icons.favorite_outline_outlined),
                            Text(retaurant.rate.toString(),
                                style: TextStyle(fontSize: 13.dp))
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.access_time_rounded),
                            Text(
                              '40m',
                              style: TextStyle(fontSize: 13.dp),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            Text('1.6km', style: TextStyle(fontSize: 13.dp))
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
                        padding: EdgeInsets.symmetric(horizontal: 24.dp),
                        child: Text(
                          dataRestaurant.keys.elementAt(index),
                          style: !active
                              ? null
                              : const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorsGlobal.globalPink),
                        ),
                      ),
                      itemBuilder: (BuildContext context, int index) => Column(
                        children: [
                          Text(
                            dataRestaurant.keys.elementAt(index),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.dp),
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
              ),),
        ],
      ),
    );
  }
}
