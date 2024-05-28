

import 'package:flutter/material.dart';

import '../../../resources/const.dart';
import '../../../widgets/custom_text.dart';

class AvatarAndName extends StatefulWidget {
  final String? name;
  final String? address;
  final String? imgUrl;
  const AvatarAndName({super.key, this.name, this.address, this.imgUrl});

  @override
  State<AvatarAndName> createState() => _AvatarAndNameState();
}

class _AvatarAndNameState extends State<AvatarAndName> {
  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (widget.imgUrl != null) {
      imageProvider = NetworkImage(widget.imgUrl!);
    } else {
      imageProvider = const AssetImage(MediaRes.avatar);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20, top: 20),
            height: Responsive.screenWidth(context) * 0.3,
            width: Responsive.screenHeight(context) * 0.3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
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
