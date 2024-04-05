import 'package:flutter/material.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';

enum Size { a, b, c }

class DetailFood extends StatefulWidget {
  const DetailFood({super.key, required this.foodItems});

  final FoodItems foodItems;

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
            height: double.maxFinite,
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
                        RadioListTile(
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
                        RadioListTile(
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
                        RadioListTile(
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
                  height: 200,
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
                      Divider(
                        thickness: 8,
                        color: dividerGrey,
                      ),
                    ],
                  ),
                ),
                SizedBox(child: Container()),
                SizedBox(child: Container()),
                SizedBox(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
