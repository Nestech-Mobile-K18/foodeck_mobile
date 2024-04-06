import 'package:flutter/material.dart';
import 'package:template/pages/map/map_view.dart';
import 'package:template/pages/profile/widgets/components/function_header.dart';
import 'package:template/pages/profile/widgets/components/function_items.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        const FunctionHeader(headerText: StringExtensions.accountSettings),
        FunctionItems(
            functionName: StringExtensions.editAccount,
            imgString: MediaRes.editAccount,
            isDividers: true,
            onTap: () {
              // Navigates to edit profile screen
            }),
        FunctionItems(
            functionName: StringExtensions.myLocation,
            imgString: MediaRes.myLocation,
            isDividers: true,
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MapBoxView()));
            }),
        FunctionItems(
            functionName: StringExtensions.myOrders,
            imgString: MediaRes.myOrders,
            isDividers: true,
            onTap: () {
              // Navigates to edit profile screen
            }),
        FunctionItems(
            functionName: StringExtensions.paymentMethods,
            imgString: MediaRes.paymentMethos,
            isDividers: true,
            onTap: () {
              // Navigates to edit profile screen
            }),
        FunctionItems(
            functionName: StringExtensions.myReviews,
            imgString: MediaRes.myReviews,
            isDividers: false,
            onTap: () {
              // Navigates to edit profile screen
            }),
      ],
    );
  }
}
