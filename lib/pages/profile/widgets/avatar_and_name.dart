import 'package:flutter/material.dart';

import '../../../resources/const.dart';
import '../../../widgets/custom_text.dart';

class AvatarAndName extends StatefulWidget {
  final String? name;
  final String? address;
  const AvatarAndName({super.key, this.name, this.address});

  @override
  State<AvatarAndName> createState() => _AvatarAndNameState();
}

class _AvatarAndNameState extends State<AvatarAndName> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 50),
              height: Responsive.screenWidth(context) * 0.3,
              width: Responsive.screenHeight(context) * 0.3,
              child: CircleAvatar(
                child: Image.asset(
                  MediaRes.avatar,
                ),
              ),
            ),
          ],
        ),
        CustomText(
          title: widget.name ?? 'John Doe',
          color: ColorsGlobal.globalBlack,
          fontWeight: FontWeight.w700,
          size: 20,
        ),
        CustomText(
          title: widget.address ?? 'Lahore, Pakistan',
          color: ColorsGlobal.textGrey,
          fontWeight: FontWeight.w500,
          size: 15,
        ),
      ],
    );
  }
}
