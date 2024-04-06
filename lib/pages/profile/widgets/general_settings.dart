import 'package:flutter/material.dart';

import '../../../resources/const.dart';
import 'components/function_header.dart';
import 'components/function_items.dart';

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({super.key});

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
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
            isDividers: false,
            onTap: () {
              // Navigates to edit profile screen
            }),
      ],
    );
  }
}
