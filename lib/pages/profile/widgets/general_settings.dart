import 'package:flutter/material.dart';
import 'package:template/pages/login/views/login_view.dart';

import '../../../resources/const.dart';
import '../../../services/api.dart';
import '../../../services/auth_manager.dart';
import '../vm/profile_view_model.dart';
import 'components/function_header.dart';
import 'components/function_items.dart';

class GeneralSettings extends StatefulWidget {

  const GeneralSettings({super.key});

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  final API _api = API();
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        const FunctionHeader(headerText: StringExtensions.generalSettings),
        FunctionItems(
            functionName: StringExtensions.aboutUs,
            imgString: MediaRes.aboutUs,
            isDividers: true,
            onTap: () {
              // Navigates to edit profile screen
            }),
        FunctionItems(
            functionName: StringExtensions.dataUsage,
            imgString: MediaRes.dataUsage,
            isDividers: true,
            onTap: () {
              // Navigates to edit profile screen
            }),
        FunctionItems(
            functionName: StringExtensions.logOut,
            imgString: MediaRes.logOut,
            isDividers: false,
            onTap: () async{
              await _api.logOut();
              // Clear dữ liệu isLoggedIn và userId từ SharedPreferences
              await AuthManager.setLoggedIn(false);
              await AuthManager.setUserId(null);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginView()), (route) => false);
            },),
      ],
    );
  }
}
