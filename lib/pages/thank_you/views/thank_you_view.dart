import 'package:flutter/material.dart';
import 'package:template/pages/application/views/application_view.dart';
import 'package:template/pages/home/view/home_view.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';
import 'package:template/widgets/method_button.dart';

class ThankYouView extends StatefulWidget {
  final String? addressUser;

  const ThankYouView({super.key, this.addressUser});

  @override
  State<ThankYouView> createState() => _ThankYouViewState();
}

class _ThankYouViewState extends State<ThankYouView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Container(
              width: Responsive.screenWidth(context) * 0.2,
              height: Responsive.screenHeight(context) * 0.2,
              decoration: const BoxDecoration(
                  color: ColorsGlobal.globalGreen, shape: BoxShape.circle),
              child: const Icon(Icons.done,
                  color: ColorsGlobal.globalWhite, size: 40),
            ),
            const CustomText(
              title: 'Thank you for placing the order',
              color: ColorsGlobal.globalBlack,
              size: 20,
              fontWeight: FontWeight.bold,
            ),
            const CustomText(
              title: 'We’ll get to you as soon as possible',
              color: ColorsGlobal.textGrey,
              size: 20,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: Responsive.screenHeight(context) * 0.1),
            Image.asset(MediaRes.isDelivery),
            SizedBox(height: Responsive.screenHeight(context) * 0.2),
            MethodButton(
              color: ColorsGlobal.globalPink,
              title: 'Go Home',
              widthButton: Responsive.screenWidth(context) * 0.8,
              onTap: () {
                Navigator
                    .of(context)
                    .push(MaterialPageRoute(builder:
                    (context) => ApplicationView()))
                    ;
                },
            )
          ],
        ),
      ),
    );
  }
}
