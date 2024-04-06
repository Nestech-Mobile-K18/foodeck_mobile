import 'package:flutter/material.dart';

import '../../../../resources/const.dart';
import '../../../../widgets/custom_text.dart';

class FunctionHeader extends StatelessWidget {
  final String? headerText;
  const FunctionHeader({super.key, required this.headerText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomText(
              title: headerText,
              color: ColorsGlobal.globalPink,
              fontWeight: FontWeight.w700,
              size: 17,
            )),
      ],
    );
  }
}
