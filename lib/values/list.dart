import 'package:flutter/material.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';
import 'package:template/values/text_styles.dart';

class LoginButton {
  final String type;
  final String loginText;
  final Color backGroundColor;

  LoginButton(this.type, this.loginText, this.backGroundColor);
}

List<LoginButton> loginButton = [
  LoginButton(googleLogo, 'Login via Google', buttonRed),
  LoginButton(facebookLogo, 'Login via Facebook', buttonBlue),
  LoginButton(appleLogo, 'Login via Apple', Colors.black),
  LoginButton(emailLogo, 'Login via Email', globalPink),
  LoginButton('', 'Create an account', Colors.white)
];

class SlideBanner {
  final String foodBanner;
  final Widget content;

  SlideBanner(this.foodBanner, this.content);
}

List<SlideBanner> slideBanner = [
  SlideBanner(
      firstBanner,
      Positioned(
        left: 24,
        child: RichText(
            text: TextSpan(
                text: 'Get 25% Cashback',
                style: inter.copyWith(fontSize: 15, color: globalPink),
                children: [
              TextSpan(
                  text: ' on\ngrocery from our retailers\n',
                  style: inter.copyWith(color: Colors.black)),
              WidgetSpan(
                  child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  alignment: Alignment.center,
                  height: 28,
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(800),
                      color: globalPink),
                  child: Text(
                    'Code: CVB25',
                    style: inter.copyWith(fontSize: 10, color: Colors.white),
                  ),
                ),
              ))
            ])),
      )),
  SlideBanner(
      middleBanner,
      Positioned(
        left: 24,
        child: RichText(
            text: TextSpan(
                text: 'Pizza Party\n',
                style: inter.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                children: [
              const WidgetSpan(
                  child: SizedBox(
                height: 20,
              )),
              TextSpan(
                  text: 'Enjoy pizza from Johnny\nand get up to 30% off\n',
                  style: inter.copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal)),
              const WidgetSpan(
                  child: SizedBox(
                height: 20,
              )),
              TextSpan(
                  text: '\nStarting from\n',
                  style: inter.copyWith(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal)),
              TextSpan(text: '\$10', style: inter.copyWith(color: globalPink))
            ])),
      )),
  SlideBanner(
      lastBanner,
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: '30% FLAT\n',
              style: inter.copyWith(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              children: [
                TextSpan(
                    text: 'on any IceCreams\n',
                    style: inter.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)),
                WidgetSpan(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    alignment: Alignment.center,
                    height: 28,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(800),
                        color: buttonShadowBlack),
                    child: Text(
                      'Shop Now',
                      style: inter.copyWith(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ))
              ]))),
];

class MiddleList {
  final String foodOrder;
  final String time;
  final String shopName;
  final String place;
  final String vote;
  MiddleList(this.foodOrder, this.time, this.shopName, this.place, this.vote);
}

List<MiddleList> middleList = [
  MiddleList(dailyDeli, '40 min', 'Daily Deli\n', 'Johar Town', '4.8'),
  MiddleList(riceBowl, '12 min', 'Rice Bowl\n', 'Wapda Town', '4.8'),
  MiddleList(healthyFood, '25 min', 'Healthy Food\n', 'Grand Town', '4.4'),
  MiddleList(indonesianFood, '30 min', 'Indonesian Food\n', 'Rolan Town', '5'),
  MiddleList(coffee, '15 min', 'Coffee\n', 'Mid Town', '4.7')
];

class BottomList {
  final String bottomFood;
  final String timeSend;
  final String popular;
  final String zone;
  final String star;

  BottomList(
      this.bottomFood, this.timeSend, this.popular, this.zone, this.star);
}

List<BottomList> bottomList = [
  BottomList(cake, '40 min', 'Jean’s Cakes\n', 'Johar Town', '4.8'),
  BottomList(chocolate, '20 min', 'Thicc Shakes\n', 'Wapda Town', '4.5'),
  BottomList(panCake, '30 min', 'Daily Deli\n', 'Garden Town', '4.8')
];
