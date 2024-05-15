import 'package:flutter/material.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';
import 'package:template/widgets/custom_text.dart';

class LoginButton {
  final String type;
  final String loginText;
  final Color backGroundColor;

  LoginButton(this.type, this.loginText, this.backGroundColor);
}

List<LoginButton> loginButton = [
  LoginButton(Assets.googleLogo, 'Login via Google', buttonRed),
  LoginButton(Assets.facebookLogo, 'Login via Facebook', buttonBlue),
  LoginButton(Assets.appleLogo, 'Login via Apple', Colors.black),
  LoginButton(Assets.emailLogo, 'Login via Email', globalPink),
  LoginButton('', 'Create an account', Colors.white)
];

class SlideBanner {
  final String foodBanner;
  final Widget content;

  SlideBanner(this.foodBanner, this.content);
}

List<SlideBanner> slideBanner = [
  SlideBanner(
      Assets.firstBanner,
      Positioned(
          left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                  content: 'Get 25% Cashback', fontSize: 15, color: globalPink),
              const CustomText(content: 'on grocery from our retailers\n'),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                    alignment: Alignment.center,
                    height: 28,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(800),
                        color: globalPink),
                    child: const CustomText(
                        content: 'Code: CVB25',
                        fontSize: 10,
                        color: Colors.white)),
              )
            ],
          ))),
  SlideBanner(
      Assets.middleBanner,
      const Positioned(
          left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  content: 'Pizza Party',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 10,
              ),
              CustomText(
                  content: 'Enjoy pizza from Johnny\nand get up to 30% off',
                  fontSize: 12,
                  color: Colors.grey),
              SizedBox(
                height: 10,
              ),
              CustomText(
                  content: '\nStarting from\n',
                  fontSize: 10,
                  color: Colors.grey),
              CustomText(content: '\$10', color: globalPink)
            ],
          ))),
  SlideBanner(
      Assets.lastBanner,
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const CustomText(
            content: '30% FLAT',
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        const CustomText(content: 'on any IceCreams', fontSize: 12),
        Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
                alignment: Alignment.center,
                height: 28,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(800),
                    color: buttonShadowBlack),
                child: const CustomText(
                    content: 'Shop Now', fontSize: 10, color: Colors.white)))
      ])),
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

enum TitleFood { Deals, Explore, Popular, Recent }

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
  ProfileButtons(Assets.userCircle, 'Edit Account', KindSetting.account),
  ProfileButtons(Assets.mapPin, 'My locations', KindSetting.account),
  ProfileButtons(Assets.package, 'My Orders', KindSetting.account),
  ProfileButtons(Assets.creditCardIcon, 'Payment Methods', KindSetting.account),
  ProfileButtons(Assets.starBorder, 'My reviews', KindSetting.account),
  ProfileButtons(Assets.info, 'About us', KindSetting.general),
  ProfileButtons(Assets.database, 'Data usage', KindSetting.general),
];

enum KindSetting { account, general }
