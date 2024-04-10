import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/pages/deals/detail_page/add_cart.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';
import 'package:template/widgets/buttons.dart';
import 'package:template/widgets/form_fill.dart';

enum Size { a, b, c }

class DetailFood extends StatefulWidget {
  final FoodItems foodItems;
  final Map<Addon, bool> select = {};

  DetailFood({super.key, required this.foodItems}) {
    for (Addon addon in foodItems.availableAddons) {
      select[addon] = false;
    }
  }

  @override
  State<DetailFood> createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  Size? change = Size.a;
  int number = 1;
  int number1 = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 200,
          flexibleSpace: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.foodItems.picture),
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
                            text: widget.foodItems.nameFood,
                            style: inter.copyWith(
                                fontSize: 22, fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                              text: widget.foodItems.place,
                              style: inter.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.normal))
                        ])),
                  )
                ],
              )),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 1200,
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(
                    height: 290,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Variation',
                                  style: inter.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text('Required',
                                  style: inter.copyWith(
                                      fontSize: 17, color: globalPink))
                            ],
                          ),
                        ),
                        RadioListTile.adaptive(
                          secondary:
                              Text('\$10', style: inter.copyWith(fontSize: 17)),
                          title:
                              Text('8"', style: inter.copyWith(fontSize: 17)),
                          activeColor: globalPink,
                          value: Size.a,
                          groupValue: change,
                          onChanged: (value) {
                            setState(() {
                              change = value;
                            });
                          },
                        ),
                        Divider(color: Colors.grey[300]),
                        RadioListTile.adaptive(
                          secondary:
                              Text('\$12', style: inter.copyWith(fontSize: 17)),
                          title:
                              Text('10"', style: inter.copyWith(fontSize: 17)),
                          activeColor: globalPink,
                          value: Size.b,
                          groupValue: change,
                          onChanged: (value) {
                            setState(() {
                              change = value;
                            });
                          },
                        ),
                        Divider(color: Colors.grey[300]),
                        RadioListTile.adaptive(
                          secondary:
                              Text('\$16', style: inter.copyWith(fontSize: 17)),
                          title:
                              Text('12"', style: inter.copyWith(fontSize: 17)),
                          activeColor: globalPink,
                          value: Size.c,
                          groupValue: change,
                          onChanged: (value) {
                            setState(() {
                              change = value;
                            });
                          },
                        ),
                        Divider(
                          thickness: 8,
                          color: dividerGrey,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 160,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quanity',
                                style: inter.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 15),
                              child: Container(
                                height: 54,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          if (number == 0) {
                                            number = 10;
                                            number1--;
                                          } else if (number < 1 ||
                                              number1 < 0) {
                                            null;
                                          } else {
                                            setState(() {
                                              number--;
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.remove)),
                                    Text('$number1$number'),
                                    IconButton(
                                        onPressed: () {
                                          if (number >= 9) {
                                            number = -1;
                                            number1++;
                                          }
                                          setState(() {
                                            number++;
                                          });
                                        },
                                        icon: Icon(Icons.add))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Divider(
                          thickness: 8,
                          color: dividerGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
                  child: SizedBox(
                      height: 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 24, bottom: 10),
                            child: Text('Extra Sauce',
                                style: inter.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 110,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount:
                                    widget.foodItems.availableAddons.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Addon addon =
                                      widget.foodItems.availableAddons[index];
                                  return CheckboxListTile.adaptive(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    secondary: Text(
                                      addon.price.toString(),
                                      style: inter.copyWith(
                                          fontSize: 17, color: Colors.grey),
                                    ),
                                    title: Text(
                                      addon.addonName,
                                      style: inter.copyWith(
                                          fontSize: 17, color: Colors.grey),
                                    ),
                                    value: widget.select[addon],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        widget.select[addon] = value!;
                                      });
                                    },
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Divider(
                              thickness: 8,
                              color: dividerGrey,
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                    child: Column(
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Instructions\n',
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
                                  'Let us know if you have specific things in\nmind',
                              style: inter.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey))
                        ])),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 15),
                      child: CustomFormFill(
                        borderColor: Colors.grey[400],
                        hintText: 'e.g. less spices, no mayo etc',
                        focusErrorBorderColor: Colors.grey[400],
                        inputColor: Colors.grey[400],
                        hintColor: Colors.grey[400],
                      ),
                    ),
                    Divider(
                      thickness: 8,
                      color: dividerGrey,
                    )
                  ],
                )),
                SizedBox(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Text('If the product is not available',
                            style: inter.copyWith(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 60),
                        child: DropdownButtonFormField(
                          iconEnabledColor: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20),
                          hint: Text(
                            'Remove it from my order',
                            style: inter.copyWith(
                                fontSize: 17, color: Colors.grey.shade400),
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
                                value: 'Remove it from my order',
                                child: Text('Remove it from my order',
                                    style: inter.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey))),
                            DropdownMenuItem(
                                value: '',
                                child: Text('',
                                    style: inter.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey))),
                            DropdownMenuItem(
                                value: '',
                                child: Text('',
                                    style: inter.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey))),
                          ],
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$20',
                        style: inter.copyWith(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      CustomButton(
                        text: Text(
                          'Add to cart',
                          style: inter.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        color: globalPink,
                        heightBox: 54,
                        widthBox: 137,
                        paddingLeft: 8,
                        onPressed: () {
                          Get.to(() => AddCart(
                                foodItems: widget.foodItems,
                              ));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
