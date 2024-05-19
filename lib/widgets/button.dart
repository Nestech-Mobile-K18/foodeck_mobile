import 'package:template/pages/export.dart';

class Button extends StatelessWidget {
  final Color? colorBackgroud;
  final String label;
  final String? icon;
  final Color? colorLabel;
  final double width;
  final double height;
  final Color? colorBorder;

  final VoidCallback? onPressed;
  const Button(
      {super.key,
      this.colorBackgroud,
      required this.label,
      this.icon,
      this.colorLabel,
      required this.width,
      required this.height,
      this.onPressed,
      this.colorBorder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppPadding.p12),
      child: RawMaterialButton(
          fillColor: colorBackgroud,
          constraints: BoxConstraints.tight(Size(width, height)),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.r16),
              side: BorderSide(
                  color: colorBorder != null ? colorBorder! : ColorsGlobal.white)),
          child: Padding(
            padding:  EdgeInsets.all(AppPadding.p10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (icon != null)
                  ImageIcon(
                    AssetImage(icon!),
                    size: AppSize.s30,
                    color: ColorsGlobal.white,
                  ),
                if (icon != null)
                  const SizedBox(
                    width: 10.0,
                  ),
                Text(
                  label,
                  maxLines: 1,
                  style: TextStyle(
                      color: colorLabel,
                      fontSize: AppSize.s17,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
    );
  }
}
