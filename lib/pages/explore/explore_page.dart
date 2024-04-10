import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/pages/explore/widget/bottom_list_shopping.dart';
import 'package:template/pages/explore/widget/custom_search_delegate.dart';
import 'package:template/pages/explore/widget/list_slide_banner.dart';
import 'package:template/pages/explore/widget/middle_slide_list.dart';
import 'package:template/pages/explore/widget/top_list_shopping.dart';
import 'package:template/values/images.dart';
import 'package:template/values/text_styles.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                homeBar,
                fit: BoxFit.cover,
              )),
          toolbarHeight: 142,
          automaticallyImplyLeading: false,
          titleTextStyle: inter.copyWith(fontSize: 17, color: Colors.white),
          titleSpacing: 24,
          title: Column(
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text('Block B Phase 2 Johar Town, Lahore')
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: GestureDetector(
                    onTap: () => Get.to(() => CustomSearchDelegate()),
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
                              Image.asset(search, color: Colors.grey),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'Search...',
                                  style: inter.copyWith(
                                      color: Colors.grey[400], fontSize: 17),
                                ),
                              )
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
      ),
    );
  }
}
