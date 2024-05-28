import 'package:flutter/material.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';


import '../vm/my_reviews_view_model.dart';

class MyReviewsView extends StatefulWidget {
  const MyReviewsView({super.key});

  @override
  State<MyReviewsView> createState() => _MyReviewsViewState();
}

class _MyReviewsViewState extends State<MyReviewsView> {
  late Future<List<Map<String, dynamic>>>? _fetchMenuFuture;

  @override
  void initState() {
    super.initState();
    _fetchMenuFuture = MyReviewsViewModel().fetchMenu();
  }

  int calculateStarRating(double vote) {
    if (vote >= 4.5) {
      return 5;
    } else if (vote >= 3.5) {
      return 4;
    } else if (vote >= 2.5) {
      return 3;
    } else if (vote >= 1.5) {
      return 2;
    } else if (vote >= 0.5) {
      return 1;
    }
    return vote.round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          title: 'My Reviews',
          color: ColorsGlobal.globalBlack,
          size: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchMenuFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final menuData = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: menuData.length,
                    itemBuilder: (context, index) {
                      final menuItem = menuData[index];
                      final double vote = (menuItem['vote'] ?? 0).toDouble();
                      final int starRating = calculateStarRating(vote);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                menuItem['img_menu'],
                                fit: BoxFit.cover,
                                width: Responsive.screenWidth(context) * 0.9,
                                height: Responsive.screenWidth(context) * 0.5,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: Responsive.screenWidth(context) * 0.85,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    title: menuItem['menu_name'],
                                    size: 17,
                                    color: ColorsGlobal.globalBlack,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: ColorsGlobal.globalYellow,
                                      ),
                                      CustomText(
                                        title: vote.toString(),
                                        size: 17,
                                        color: ColorsGlobal.globalBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Responsive.screenWidth(context) * 0.8,
                              child: CustomText(
                                title: menuItem['place'],
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLine: 2,
                                size: 15,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  title: 'My Rating',
                                  size: 17,
                                  color: ColorsGlobal.globalBlack,
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => Icon(
                                      Icons.star,
                                      color: index < starRating
                                          ? ColorsGlobal.globalYellow
                                          : ColorsGlobal.globalGrey5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: Responsive.screenWidth(context) * 0.9,
                                  height:
                                      Responsive.screenHeight(context) * 0.2,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: ColorsGlobal.globalGrey)),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        title: 'My Review',
                                        color: ColorsGlobal.globalPink,
                                        size: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      SizedBox(height: 10),
                                      CustomText(
                                        title: 'There are no reviews',
                                        color: ColorsGlobal.globalBlack,
                                        size: 17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
