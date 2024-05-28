import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/resources/const.dart';

class ChooseAvatar extends StatefulWidget {
  final VoidCallback? chooseAvatar;
  final XFile? imgFile;
  final String? imgUrl;
  const ChooseAvatar({super.key, this.chooseAvatar, this.imgFile, this.imgUrl});

  @override
  State<ChooseAvatar> createState() => _ChooseAvatarState();
}

class _ChooseAvatarState extends State<ChooseAvatar> {
  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (widget.imgFile != null || widget.imgUrl != null) {
      // Kiểm tra cả imgFile và imgUrl
      if (widget.imgFile is XFile) {
        imageProvider = FileImage(File(widget.imgFile!.path));
      } else if (widget.imgUrl is String) {
        imageProvider = NetworkImage(widget.imgUrl!);
      } else {
        imageProvider = AssetImage(MediaRes.avatar);
      }
    } else {
      imageProvider = AssetImage(MediaRes.avatar);
    }

    return Stack(
      alignment: Alignment.center,
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
        Positioned(
          bottom: 8,
          right: -75,
          left: 0,
          child: GestureDetector(
            onTap: widget.chooseAvatar,
            child: Container(
              height: Responsive.screenHeight(context) * 0.06,
              width: Responsive.screenHeight(context) * 0.06,
              decoration: const BoxDecoration(
                color: ColorsGlobal.globalPink,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: ColorsGlobal.globalWhite,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
