import 'package:template/source/export.dart';

class AppText {
  static TextStyle inter = GoogleFonts.inter();
}

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.content,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.textDecoration,
      this.textAlign,
      this.textOverflow});

  final String content;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(content,
        textAlign: textAlign,
        overflow: textOverflow ?? TextOverflow.ellipsis,
        style: AppText.inter.copyWith(
            fontSize: fontSize ?? 17,
            overflow: textOverflow ?? TextOverflow.ellipsis,
            fontWeight: fontWeight,
            color: color,
            decoration: textDecoration));
  }
}
