import 'package:template/source/export.dart';

class CustomWidgets {
  static customSnackBar(BuildContext context, Color color, String content) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.none,
          duration: const Duration(milliseconds: 1500),
          backgroundColor: color,
          content: CustomText(content: content)));
  }

  static Widget currentAddress(String address) {
    return AnimatedTextKit(
      totalRepeatCount: 1,
      animatedTexts: [
        TyperAnimatedText(address,
            textStyle: AppText.inter
                .copyWith(fontSize: 17, overflow: TextOverflow.ellipsis))
      ],
    );
  }
}
