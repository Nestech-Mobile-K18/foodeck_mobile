import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:template/pages/home/home_page.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';
import 'package:template/values/text_styles.dart';
import 'package:template/widgets/buttons.dart';

class OrderComplete extends StatefulWidget {
  const OrderComplete({super.key});

  @override
  State<OrderComplete> createState() => _OrderCompleteState();
}

class _OrderCompleteState extends State<OrderComplete> {
  @override
  void initState() {
    backHome();
    super.initState();
  }

  Future backHome() async {
    Future.delayed(Duration(milliseconds: 5000),
        () => Get.to(() => HomePage(), transition: Transition.zoom));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 100, child: Lottie.asset(done, fit: BoxFit.cover)),
            Text(
              'Thank you for placing the order',
              style: inter.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'We’ll get to you as soon as possible',
              style: inter.copyWith(fontSize: 17, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 70),
              child: SizedBox(
                  height: 250,
                  child: Lottie.asset(delivery, fit: BoxFit.cover)),
            ),
            CustomButton(
                onPressed: () {
                  Get.to(() => HomePage(), transition: Transition.zoom);
                },
                text: Text('Go Home',
                    style: inter.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                color: globalPink)
          ],
        ),
      ),
    );
  }
}
