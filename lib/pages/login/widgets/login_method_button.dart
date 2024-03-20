import 'package:flutter/material.dart';

class LoginMethodButton extends StatelessWidget {
  final Color? color;
  final String? title;
  final String? assetIcon;
  final VoidCallback? onTap;
  final bool? isIcon;

  const LoginMethodButton({
    super.key,
    required this.color,
    required this.title,
    this.assetIcon,
    this.isIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 22),
        alignment: Alignment.center,
        width: double.infinity,
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
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
