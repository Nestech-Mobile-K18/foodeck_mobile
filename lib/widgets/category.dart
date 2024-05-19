import 'package:template/pages/export.dart';

class Category extends StatelessWidget {
  const Category(
      {Key? key,
      this.height,
      this.width,
      required this.img,
      required this.title,
      this.decription,
      this.right,
      this.left,
      this.bottom,
      this.top})
      : super(key: key);
  final double? height;
  final double? width;
  final String img;
  final String title;
  final String? decription;
  final double? right;
  final double? left;
  final double? bottom;
  final double? top;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.fromLTRB(left ?? AppMargin.m0, top ?? AppMargin.m0,
          right ?? AppMargin.m0, bottom ?? AppMargin.m0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r16),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              softWrap: true,
              style: TextStyle(
                  color: ColorsGlobal.white,
                  fontSize: AppSize.s22,
                  fontWeight: FontWeight.w400),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(decription ?? '',
                  maxLines: 2,
                  style: TextStyle(color: ColorsGlobal.white, fontSize: AppSize.s16)),
            )
          ],
        ),
      ),
    );
  }
}
