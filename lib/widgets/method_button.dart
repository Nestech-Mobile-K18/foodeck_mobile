import 'package:flutter/material.dart';

class MethodButton extends StatelessWidget {
  final Color? color;
  final String? title;
  final String? assetIcon;
  final VoidCallback? onTap;
  final bool? isIcon;
  final double? widthButton;
  final double? heightButton;
  final double? fontSizeTitle;

  const MethodButton(
      {super.key,
      required this.color,
      required this.title,
      this.assetIcon,
      this.isIcon,
      this.onTap,
      this.fontSizeTitle,
      this.heightButton,
      this.widthButton});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 22),
        alignment: Alignment.center,
        width: widthButton ?? double.infinity,
        height: heightButton,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isIcon == true) Image.asset("$assetIcon"),
            const SizedBox(
              width: 10,
            ),
            Text(
              "$title",
              style: TextStyle(
                fontSize: fontSizeTitle ?? 17,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
