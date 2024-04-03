import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:template/resources/const.dart';

class DeepLink extends StatelessWidget {
  final VoidCallback? onTap;
  const DeepLink({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(fontFamily: 'Inter', fontWeight: FontWeight.w500),
          children: <TextSpan>[
            const TextSpan(
              text: StringExtensions.privacyAndPolicy,
              style: TextStyle(
                  color: ColorsGlobal.globalGrey,
                  fontSize: 16,
                  decoration: TextDecoration.none),
            ),
            const TextSpan(
              text: '', // Khoảng trắng
            ),
            TextSpan(
              text: StringExtensions.termsAndConditions,
              style: const TextStyle(
                  color: ColorsGlobal.globalPink,
                  fontSize: 16,
                  decoration: TextDecoration.none),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
