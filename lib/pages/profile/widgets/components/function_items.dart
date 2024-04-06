import 'package:flutter/material.dart';

import '../../../../resources/const.dart';
import '../../../../widgets/custom_text.dart';

class FunctionItems extends StatelessWidget {
  final String? imgString;
  final String? functionName;
  final bool? isDividers;
  final VoidCallback? onTap;
  const FunctionItems(
      {super.key,
      required this.functionName,
      required this.imgString,
      this.onTap,
      this.isDividers});

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
            trailing: const Icon(Icons.arrow_forward_ios_outlined,
                color: ColorsGlobal.globalGrey),
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
