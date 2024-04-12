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

class DesktopFood {
  final String foodOrder;
  final String time;
  final String shopName;
  final String place;
  final String vote;
  final TitleFood titleFood;

  DesktopFood(
      {required this.foodOrder,
      required this.time,
      required this.shopName,
      required this.place,
      required this.vote,
      required this.titleFood});
}

enum TitleFood { Deals, Explore, Popular }

class FoodItems {
  final String picture;
  final String nameFood;
  final String detail;
  final int price;
  final String place;
  int quantityFood;

  final FoodCategory foodCategory;

  List<Addon> availableAddons;

  FoodItems(
      {this.quantityFood = 1,
      required this.place,
      required this.picture,
      required this.nameFood,
      required this.detail,
      required this.price,
      required this.foodCategory,
      required this.availableAddons});
}

enum FoodCategory { Popular, Deals, Wraps, Beverages, Sandwiches }

class Addon {
  final String addonName;
  final String size;
  final int priceSize;
  final int price;
  RadioType radio;

  Addon(
      {required this.radio,
      required this.addonName,
      required this.size,
      required this.priceSize,
      required this.price});
}

enum RadioType { a, b, c }

class ProfileButtons {
  final String icon;
  final String info;
  final KindSetting kindSetting;

  ProfileButtons(this.icon, this.info, this.kindSetting);
}

List<ProfileButtons> profileButtons = [
  ProfileButtons(userCircle, 'Edit Account', KindSetting.account),
  ProfileButtons(mapPin, 'My locations', KindSetting.account),
  ProfileButtons(package, 'My Orders', KindSetting.account),
  ProfileButtons(creditCard, 'Payment Methods', KindSetting.account),
  ProfileButtons(starBorder, 'My reviews', KindSetting.account),
  ProfileButtons(info, 'About us', KindSetting.general),
  ProfileButtons(database, 'Data usage', KindSetting.general),
];

enum KindSetting { account, general }
