import 'package:flutter/material.dart';
import 'package:template/widgets/cross_bar.dart';
import 'package:template/widgets/custom_text.dart';

import '../../../resources/const.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          title: 'Notifications',
          color: ColorsGlobal.globalBlack,
          size: 20,
          fontWeight: FontWeight.w700,
        ),
        automaticallyImplyLeading: false,
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: CustomText(
              title: 'Your order has arrived',
              size: 17,
              fontWeight: FontWeight.w400,
              color: ColorsGlobal.globalBlack,
            ),
            trailing: CustomText(title: '2m',size: 17,fontWeight: FontWeight.w400,),
          ),
          CrossBar(height: 2),
          ListTile(
            title: CustomText(
              title: 'Your order is on its way',
              size: 17,
              fontWeight: FontWeight.w400,
              color: ColorsGlobal.globalBlack,
            ),
            trailing: CustomText(title: '50m',size: 17,fontWeight: FontWeight.w400,),
          ),
          CrossBar(height: 2),
          ListTile(
            title: CustomText(
              title: 'Your order has been placed',
              size: 17,
              fontWeight: FontWeight.w400,
              color: ColorsGlobal.globalBlack,
            ),
            trailing: CustomText(title: '1h',size: 17,fontWeight: FontWeight.w400,),
          ),
          CrossBar(height: 2),
          ListTile(
            title: CustomText(
              title: 'Confirm your phone number',
              size: 17,
              fontWeight: FontWeight.w400,
              color: ColorsGlobal.globalBlack,
            ),
            trailing: CustomText(title: '5d',size: 17,fontWeight: FontWeight.w400,),
          ),
          CrossBar(height: 2),
          ListTile(
            title: CustomText(
              title: 'We have updated our Privacy Policy',
              size: 17,
              fontWeight: FontWeight.w400,
              color: ColorsGlobal.globalBlack,
            ),
            subtitle: CustomText(title: 'View Privacy Policy',size: 17,fontWeight: FontWeight.w400,),
            trailing: CustomText(title: '6d',size: 17,fontWeight: FontWeight.w400,),
          ),
          CrossBar(height: 2),
          ListTile(
            title: CustomText(
              title: 'Your order has been cancelled',
              size: 17,
              fontWeight: FontWeight.w400,
              color: ColorsGlobal.globalBlack,
            ),
            trailing: CustomText(title: '1w',size: 17,fontWeight: FontWeight.w400,),
          ),
          CrossBar(height: 2),
          ListTile(
            title: CustomText(
              title: 'Your order has been placed',
              size: 17,
              fontWeight: FontWeight.w400,
              color: ColorsGlobal.globalBlack,
            ),
            trailing: CustomText(title: '1w',size: 17,fontWeight: FontWeight.w400,),
          ),
          CrossBar(height: 2),
          ListTile(
            title: CustomText(
              title: 'Welcome to Foodeck',
              size: 17,
              fontWeight: FontWeight.w400,
              color: ColorsGlobal.globalBlack,
            ),
            subtitle: CustomText(title: 'Watch our video',size: 17,fontWeight: FontWeight.w400,),
            trailing: CustomText(title: '1w',size: 17,fontWeight: FontWeight.w400,),
          ),
        ],
      ),
    );
  }
}
