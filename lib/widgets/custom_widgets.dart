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
          duration: Duration(milliseconds: 1500),
          backgroundColor: color,
          content: CustomText(content: content)));
  }

  static Widget currentAddress(String address, String address1) {
    return AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        TyperAnimatedText(address,
            textStyle: AppText.inter.copyWith(fontSize: 17)),
        TyperAnimatedText(address1,
            textStyle: AppText.inter.copyWith(fontSize: 17)),
      ],
    );
  }
}
