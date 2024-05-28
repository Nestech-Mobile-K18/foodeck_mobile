import 'package:flutter/material.dart';

import '../../../../resources/const.dart';
import '../../../../widgets/custom_text.dart';

/// A widget representing a header for a specific function or section.
class FunctionHeader extends StatelessWidget {
  /// The text to be displayed as the header.
  final String? headerText;

  /// Constructor for the FunctionHeader widget.
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
          ),
        ),
      ],
    );
  }
}
