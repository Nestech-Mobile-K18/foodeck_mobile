import 'package:flutter/material.dart';

class LoginMethodButton extends StatelessWidget {
  final Color? color;
  final String? title;
  final String? assetIcon;
  final VoidCallback? onTap;

  const LoginMethodButton({
    super.key,
    required this.color,
    required this.title,
    required this.assetIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        height: 65,
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
            Image.asset("$assetIcon"),
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
