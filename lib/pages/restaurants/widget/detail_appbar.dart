import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class DetailAppBar extends StatefulWidget {
  const DetailAppBar(
      {super.key,
      required this.image,
      required this.name,
      required this.place,
      required this.restaurant});

  final RestaurantModel restaurant;
  final String image, name, place;

  @override
  State<DetailAppBar> createState() => _DetailAppBarState();
}

class _DetailAppBarState extends State<DetailAppBar> {
  final reviewController = TextEditingController();
  double rate = 1;

  @override
  void dispose() {
    reviewController.clear();
    super.dispose();
  }

  void sent() {
    if (reviewController.text.isNotEmpty) {
      RiveUtils.changeSMITriggerState(RiveUtils.reviewModel.statusTrigger!);
      addReview();
      Future.delayed(
          const Duration(milliseconds: 3000), () => Navigator.pop(context));
    } else {
      null;
    }
  }

  Future addReview() async {
    try {
      if (reviewController.text.isEmpty) {
        return null;
      } else {
        await supabase.from('reviews').insert({
          'restaurant_image': widget.restaurant.image,
          'restaurant_name': widget.restaurant.shopName,
          'time': widget.restaurant.deliveryTime,
          'place': widget.restaurant.address,
          'vote': widget.restaurant.rate,
          'my_vote': rate,
          'my_review': reviewController.text.trim()
        });
      }
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1500),
          backgroundColor: AppColor.buttonShadowBlack,
          content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 1500),
          backgroundColor: AppColor.buttonShadowBlack,
          content: Text('Error occurred, please retry')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.image), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
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
                        color: AppColor.globalPink,
                        onPressed: null,
                        icon: SavedListData.saveFood.contains(widget.restaurant)
                            ? const Icon(
                                Icons.favorite,
                                color: AppColor.globalPink,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Share.share('text');
                        },
                        child: Image.asset(
                          Assets.shareNetwork,
                          color: Colors.white,
                          height: 22,
                          width: 22,
                        ),
                      ),
                      PopupMenuButton(
                        iconSize: 30,
                        iconColor: Colors.white,
                        color: AppColor.dividerGrey,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              onTap: () {},
                              padding: EdgeInsets.zero,
                              child: TextButton.icon(
                                onPressed: null,
                                label: const CustomText(content: 'Report'),
                                icon: const Icon(Icons.flag),
                              )),
                          PopupMenuItem(
                              onTap: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                          titlePadding: const EdgeInsets.only(
                                              left: 10, top: 24, right: 24),
                                          title: CupertinoTextFormFieldRow(
                                            validator: (value) {
                                              if (reviewController
                                                  .text.isNotEmpty) {
                                                return '';
                                              } else {
                                                return 'It\'s empty';
                                              }
                                            },
                                            autovalidateMode:
                                                AutovalidateMode.always,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade300),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24)),
                                            controller: reviewController,
                                            onChanged: (value) {},
                                            maxLines: 5,
                                          ),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24),
                                              child: RatingBar.builder(
                                                itemSize: 22,
                                                initialRating: rate,
                                                minRating: 1,
                                                maxRating: 5,
                                                unratedColor: Colors.grey,
                                                updateOnDrag: true,
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                onRatingUpdate: (value) {
                                                  setState(() {
                                                    rate = value;
                                                  });
                                                },
                                              ),
                                            ),
                                            RiveAnimations.reviewAnimation(sent)
                                          ],
                                        ));
                              },
                              padding: EdgeInsets.zero,
                              child: TextButton.icon(
                                onPressed: null,
                                label: const CustomText(content: 'Review'),
                                icon: const Icon(Icons.rate_review),
                              )),
                          PopupMenuItem(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRouter.myLocation);
                              },
                              padding: EdgeInsets.zero,
                              child: TextButton.icon(
                                onPressed: null,
                                label: const CustomText(content: 'Map'),
                                icon: const Icon(Icons.location_on),
                              )),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 21),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          content: widget.name,
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      CustomText(
                          content: widget.place,
                          color: Colors.white,
                          fontSize: 15)
                    ]))
          ],
        ));
  }
}
