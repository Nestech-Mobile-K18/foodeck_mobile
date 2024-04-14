import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:template/models/restaurant.dart';
import 'package:template/pages/deals/detail_page/order_complete.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';
import 'package:template/widgets/form_fill.dart';

import '../../../values/text_styles.dart';
import '../../../widgets/buttons.dart';

class CheckOut extends StatefulWidget {
  const CheckOut(
      {super.key,
      required this.subPrice,
      required this.deliveryFee,
      required this.vat,
      required this.coupon,
      required this.totalPrice});

  final int subPrice;
  final int deliveryFee;
  final int vat;
  final int coupon;
  final int totalPrice;

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.95);

  int currentCard = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (BuildContext context, Restaurant value, Widget? child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            appBar: AppBar(
              shape: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 8, color: dividerGrey)),
              title: Text('Checkout',
                  style: inter.copyWith(
                      fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 278,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: 'Delivery Address\n',
                                        style: inter.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                      WidgetSpan(
                                          child: SizedBox(
                                        height: 30,
                                      )),
                                      TextSpan(
                                          text:
                                              'Block P Phase 1 Johar Town, Lahore',
                                          style: inter.copyWith(
                                              fontSize: 17,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey))
                                    ])),
                                GestureDetector(
                                    onTap: () {}, child: Image.asset(pencil))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Container(
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image: AssetImage(map),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 8,
                      color: dividerGrey,
                    ),
                    SizedBox(
                      height: 220,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: 'Delivery Instructions\n',
                                    style: inter.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: [
                                  WidgetSpan(
                                      child: SizedBox(
                                    height: 30,
                                  )),
                                  TextSpan(
                                      text:
                                          'Let us know if you have specific things in mind',
                                      style: inter.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey))
                                ])),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: CustomFormFill(
                                hintText: 'e.g. I am home around 10 pm',
                                hintColor: Colors.grey,
                                inputColor: Colors.grey,
                                focusErrorBorderColor: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 8,
                      color: dividerGrey,
                    ),
                    SizedBox(
                      height: 288,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 24, right: 20, left: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Payment Method',
                                    style: inter.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.add))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, right: 24),
                            child: SizedBox(
                              height: 170,
                              child: PageView.builder(
                                scrollBehavior: const ScrollBehavior(),
                                onPageChanged: (value) {
                                  currentCard = value;
                                },
                                controller: pageController,
                                clipBehavior: Clip.none,
                                itemCount: payment.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  payment[index].type),
                                              fit: BoxFit.cover))),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 8,
                      color: dividerGrey,
                    ),
                    SizedBox(
                      height: (value.cartItems.length * 80) + 560,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order Summary',
                                style: inter.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: value.cartItems.length * 80,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: value.cartItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${value.cartItems[index].quantity}x ${value.cartItems[index].foodItems.nameFood}',
                                              style:
                                                  inter.copyWith(fontSize: 17),
                                            ),
                                            Text(
                                              '\$${value.cartItems[index].price}',
                                              style:
                                                  inter.copyWith(fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(color: Colors.grey[300])
                                    ],
                                  );
                                },
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Subtotal',
                                          style: inter.copyWith(fontSize: 17)),
                                      Text('\$${widget.subPrice}',
                                          style: inter.copyWith(fontSize: 17))
                                    ],
                                  ),
                                ),
                                Divider(color: Colors.grey[300]),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Delivery Fee',
                                          style: inter.copyWith(fontSize: 17)),
                                      Text('\$${widget.deliveryFee}',
                                          style: inter.copyWith(fontSize: 17))
                                    ],
                                  ),
                                ),
                                Divider(color: Colors.grey[300]),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('VAT',
                                          style: inter.copyWith(fontSize: 17)),
                                      Text('\$${widget.vat}',
                                          style: inter.copyWith(fontSize: 17))
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
                                      Text('Coupon',
                                          style: inter.copyWith(fontSize: 17)),
                                      Text('-\$${widget.coupon}',
                                          style: inter.copyWith(
                                              fontSize: 17,
                                              color: Colors.green))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 34),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${widget.totalPrice}',
                                    style: inter.copyWith(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
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
                                    onPressed: () {
                                      Get.to(() => OrderComplete());
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
