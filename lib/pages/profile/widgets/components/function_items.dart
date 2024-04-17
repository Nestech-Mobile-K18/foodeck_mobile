import 'package:flutter/material.dart';

import '../../../../resources/const.dart';
import '../../../../widgets/custom_text.dart';

/// A widget representing individual function items.
class FunctionItems extends StatelessWidget {
  /// The string representing the image asset path.
  final String? imgString;

  /// The name of the function.
  final String? functionName;

  /// Determines whether to display a divider after the item.
  final bool? isDividers;

  /// Callback function triggered when the item is tapped.
  final VoidCallback? onTap;

  /// Constructor for the FunctionItems widget.
  const FunctionItems({
    Key? key,
    required this.functionName,
    required this.imgString,
    this.onTap,
    this.isDividers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsGlobal.globalWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            onTap: onTap,
            title: CustomText(
              title: functionName,
              size: 15,
              color: ColorsGlobal.globalBlack,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: ColorsGlobal.globalGrey,
            ),
            leading: Image.asset(
              imgString ?? '',
              height: 25,
              width: 25,
              color: ColorsGlobal.globalBlack,
            ),
          ),
          if (isDividers == true)
            const Divider(
              thickness: 0.5,
              color: ColorsGlobal.textGrey,
            ),
        ],
      ),
    );
  }
}
