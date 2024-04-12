import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/main.dart';
import 'package:template/models/desktop_food.dart';
import 'package:template/models/restaurant.dart';
import 'package:template/pages/explore/widget/banner_items.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';
import 'package:template/widgets/buttons.dart';

class AddCart extends StatefulWidget {
  const AddCart({super.key});

  @override
  State<AddCart> createState() => _AddCartState();
}

class _AddCartState extends State<AddCart> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.99);

  int currentCard = 0;
  int deliveryFee = 10;
  int vat = 4;
  int coupon = 4;

  int get totalPrice {
    int addonPrice = context
        .watch<Restaurant>()
        .cartItems
        .fold(0, (previousValue, element) => previousValue + element.price);
    return addonPrice;
  }

  int get bill {
    int getBill = totalPrice + deliveryFee + vat - coupon;
    return getBill;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
        builder: (BuildContext context, Restaurant value, Widget? child) =>
            Scaffold(
              appBar: AppBar(
                shape: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 8, color: dividerGrey)),
                title: Text('Cart',
                    style: inter.copyWith(
                        fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          itemCount: value.cartItems.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: RichText(
                                          text: TextSpan(
                                              text: value.cartItems[index]
                                                  .foodItems.nameFood,
                                              style: inter.copyWith(
                                                  fontSize: 17,
                                                  color: Colors.black),
                                              children: [
                                            TextSpan(
                                                text:
                                                    '${value.cartItems[index].size[0]} ',
                                                style: inter.copyWith(
                                                    fontSize: 15,
                                                    color: Colors.grey)),
                                            WidgetSpan(
                                                baseline:
                                                    TextBaseline.ideographic,
                                                alignment: PlaceholderAlignment
                                                    .baseline,
                                                child: Container(
                                                  height: 5,
                                                  width: 5,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.grey),
                                                )),
                                            TextSpan(
                                                text:
                                                    ' ${value.cartItems[index].selectAddon[0]} ${value.cartItems[index].selectAddon[1]}\n',
                                                style: inter.copyWith(
                                                    fontSize: 15,
                                                    color: Colors.grey)),
                                            const WidgetSpan(
                                                child: SizedBox(
                                              height: 30,
                                            )),
                                            TextSpan(
                                                text:
                                                    '\$${value.cartItems[index].price}',
                                                style: inter.copyWith(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ])),
                                      leading: Badge(
                                        largeSize: 20,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7),
                                        textStyle: inter.copyWith(fontSize: 12),
                                        backgroundColor: Colors.black,
                                        label: Text(
                                            '${value.cartItems[index].quantity}'),
                                        child: Container(
                                            width: 64,
                                            height: 64,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                image: DecorationImage(
                                                    image: AssetImage(value
                                                        .cartItems[index]
                                                        .foodItems
                                                        .picture),
                                                    fit: BoxFit.cover))),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {
                                            if (value.cartItems.length == 1) {
                                              value.removeFromList(
                                                  value.cartItems[index]);
                                              Navigator.pop(context);
                                            } else {
                                              value.removeFromList(
                                                  value.cartItems[index]);
                                            }
                                          },
                                          icon: const Icon(
                                              Icons.highlight_remove,
                                              color: Colors.grey))),
                                  Divider(color: Colors.grey[300])
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 300,
                        width: double.maxFinite,
                        decoration: BoxDecoration(color: dividerGrey),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 24, 0, 12),
                              child: Text(
                                'Popular with these',
                                style: inter.copyWith(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: SizedBox(
                                    width: 270,
                                    height: 220,
                                    child: Consumer<TopFood>(
                                      builder: (BuildContext context,
                                          TopFood drink, Widget? child) {
                                        Future saveBanner(index) async {
                                          try {
                                            await supabase.from('items').upsert({
                                              'food': drink
                                                  .kindFood(TitleFood.Popular,
                                                      desktopFood)[index]
                                                  .foodOrder,
                                              'time_delivery': drink
                                                  .kindFood(TitleFood.Popular,
                                                      desktopFood)[index]
                                                  .time,
                                              'shop_name': drink
                                                  .kindFood(TitleFood.Popular,
                                                      desktopFood)[index]
                                                  .shopName,
                                              'place': drink
                                                  .kindFood(TitleFood.Popular,
                                                      desktopFood)[index]
                                                  .place,
                                              'vote': drink
                                                  .kindFood(TitleFood.Popular,
                                                      desktopFood)[index]
                                                  .vote
                                            }).then((drink) => ScaffoldMessenger
                                                    .of(context)
                                                .showSnackBar(const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    backgroundColor:
                                                        globalPinkShadow,
                                                    content: Text(
                                                        'You just liked this item'))));
                                          } on AuthException catch (error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    duration: const Duration(
                                                        milliseconds: 1500),
                                                    backgroundColor:
                                                        buttonShadowBlack,
                                                    content:
                                                        Text(error.message)));
                                          } catch (error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    backgroundColor:
                                                        buttonShadowBlack,
                                                    content: Text(
                                                        'Error occurred, please retry')));
                                          }
                                        }

                                        Future deleteBanner(index) async {
                                          try {
                                            await supabase
                                                .from('items')
                                                .delete()
                                                .match({
                                              'food': drink
                                                  .kindFood(TitleFood.Popular,
                                                      desktopFood)[index]
                                                  .foodOrder,
                                              'time_delivery': drink
                                                  .kindFood(TitleFood.Popular,
                                                      desktopFood)[index]
                                                  .time,
                                              'shop_name': drink
                                                  .kindFood(TitleFood.Popular,
                                                      desktopFood)[index]
                                                  .shopName,
                                              'place': drink
                                                  .kindFood(TitleFood.Popular,
                                                      desktopFood)[index]
                                                  .place,
                                              'vote': drink
                                                  .kindFood(TitleFood.Popular,
                                                      desktopFood)[index]
                                                  .vote
                                            }).then((value) => ScaffoldMessenger
                                                        .of(context)
                                                    .showSnackBar(const SnackBar(
                                                        duration:
                                                            Duration(
                                                                milliseconds:
                                                                    1500),
                                                        backgroundColor:
                                                            buttonShadowBlack,
                                                        content: Text(
                                                            'You just unliked this item'))));
                                          } on AuthException catch (error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    duration: const Duration(
                                                        milliseconds: 1500),
                                                    backgroundColor:
                                                        buttonShadowBlack,
                                                    content:
                                                        Text(error.message)));
                                          } catch (error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    backgroundColor:
                                                        buttonShadowBlack,
                                                    content: Text(
                                                        'Error occurred, please retry')));
                                          }
                                        }

                                        return PageView.builder(
                                            scrollBehavior:
                                                const ScrollBehavior(),
                                            onPageChanged: (value) {
                                              currentCard = value;
                                            },
                                            controller: pageController,
                                            clipBehavior: Clip.none,
                                            itemCount: drink
                                                .kindFood(TitleFood.Popular,
                                                    desktopFood)
                                                .length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context, int index) =>
                                                BannerItems(
                                                    onTap: () {},
                                                    paddingImage:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    paddingText:
                                                        const EdgeInsets.only(
                                                            left: 3),
                                                    foodImage: drink
                                                        .kindFood(
                                                            TitleFood.Popular,
                                                            desktopFood)[index]
                                                        .foodOrder,
                                                    deliveryTime: drink
                                                        .kindFood(
                                                            TitleFood.Popular,
                                                            desktopFood)[index]
                                                        .time,
                                                    shopName: drink.kindFood(TitleFood.Popular, desktopFood)[index].shopName,
                                                    shopAddress: drink.kindFood(TitleFood.Popular, desktopFood)[index].place,
                                                    rateStar: drink.kindFood(TitleFood.Popular, desktopFood)[index].vote,
                                                    action: () {
                                                      if (!drink.saveFood
                                                          .contains(drink
                                                                  .kindFood(
                                                                      TitleFood
                                                                          .Popular,
                                                                      desktopFood)[
                                                              index])) {
                                                        drink.addToList(
                                                            drink.kindFood(
                                                                    TitleFood
                                                                        .Popular,
                                                                    desktopFood)[
                                                                index]);
                                                        saveBanner(index);
                                                      } else {
                                                        drink.removeFromList(
                                                            drink.kindFood(
                                                                    TitleFood
                                                                        .Popular,
                                                                    desktopFood)[
                                                                index]);
                                                        deleteBanner(index);
                                                      }
                                                    },
                                                    iconShape: drink.saveFood.contains(drink.kindFood(TitleFood.Popular, desktopFood)[index]) ? Icons.favorite : Icons.favorite_border,
                                                    heartColor: drink.saveFood.contains(drink.kindFood(TitleFood.Popular, desktopFood)[index]) ? globalPink : Colors.white));
                                      },
                                    )))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 0, 16),
                        child: Text(
                          'Coupon',
                          style: inter.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: DropdownButtonFormField(
                          icon: Icon(Icons.arrow_forward),
                          borderRadius: BorderRadius.circular(20),
                          hint: Text(
                            'GREELOGIX',
                            style: inter.copyWith(fontSize: 17),
                          ),
                          dropdownColor: Colors.white,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(16)),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          items: [
                            DropdownMenuItem(
                                value: 'GREELOGIX',
                                child: Text('GREELOGIX',
                                    style: inter.copyWith(fontSize: 17))),
                            DropdownMenuItem(
                                value: '',
                                child: Text('',
                                    style: inter.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey)))
                          ],
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      const Divider(
                        thickness: 8,
                        color: dividerGrey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal',
                                  style: inter.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\$${totalPrice}',
                                  style: inter.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: globalPink),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delivery Fee',
                                    style: inter.copyWith(fontSize: 17),
                                  ),
                                  Text(
                                    '\$${deliveryFee}',
                                    style: inter.copyWith(fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey[300]),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'VAT',
                                    style: inter.copyWith(fontSize: 17),
                                  ),
                                  Text(
                                    '\$${vat}',
                                    style: inter.copyWith(fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey[300]),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Coupon',
                                    style: inter.copyWith(fontSize: 17),
                                  ),
                                  Text(
                                    '-\$${coupon}',
                                    style: inter.copyWith(
                                        fontSize: 17, color: Colors.green),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 34),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$$bill',
                              style: inter.copyWith(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            CustomButton(
                              text: Text(
                                'Go to Checkout',
                                style: inter.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              color: globalPink,
                              heightBox: 54.dp,
                              widthBox: 172.dp,
                              paddingLeft: 8.dp,
                              onPressed: () {},
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
