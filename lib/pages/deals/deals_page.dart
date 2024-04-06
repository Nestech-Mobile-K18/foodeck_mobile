import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/models/restaurant.dart';
import 'package:template/pages/deals/widget/custom_sliver_appbar.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';

class DealsPage extends StatefulWidget {
  const DealsPage({super.key, this.voidCallback, required this.desktopFood});

  final DesktopFood desktopFood;
  final VoidCallback? voidCallback;

  @override
  State<DealsPage> createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: FoodCategory.values.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 200,
          flexibleSpace: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.desktopFood.foodOrder),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  shareNetwork,
                                  color: Colors.white,
                                  height: 22,
                                  width: 22,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  threeDots,
                                  height: 30,
                                  width: 30,
                                  color: Colors.white,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 21),
                    child: RichText(
                        text: TextSpan(
                            text: widget.desktopFood.shopName,
                            style: inter.copyWith(
                                fontSize: 22, fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                              text: widget.desktopFood.place,
                              style: inter.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.normal))
                        ])),
                  )
                ],
              )),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Consumer<Restaurant>(
            builder: (BuildContext context, Restaurant value, Widget? child) =>
                NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) =>
                        [const CustomSliverBar()],
                    body: TabBarView(children: value.sortFood(value.menu))),
          ),
        ),
      ),
    );
  }
}
