import 'package:flutter/material.dart';
import 'package:template/pages/export.dart';

class AppBarRestaurant extends StatelessWidget {
  const AppBarRestaurant({
    super.key,
    required this.title,
    required this.address,
    required this.isFavourite,
    required this.imageRestaurant,
  });
  final String title;
  final String address;
  final bool isFavourite;
  final String imageRestaurant;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: ColorsGlobal.globalPink,
      toolbarHeight: 100.dp,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 40.dp, vertical: 12.dp),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 20.dp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5.dp,
            ),
            Text(
              address,
              style: TextStyle(
                fontSize: 14.dp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        background: Image.asset(
          imageRestaurant,
          fit: BoxFit.cover,
        ),
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.305,
      pinned: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
          tooltip: "Like",
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.white,
          ),
          tooltip: "Share",
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert_outlined,
            color: Colors.white,
          ),
          tooltip: "More action",
          onPressed: () {},
        ),
      ],
    );
  }
}
