import 'package:template/src/pages/export.dart';

class BottomCheckout extends StatelessWidget {
  const BottomCheckout(
      {Key? key,
      required this.label,
      required this.price,
      this.width,
      this.onPressed})
      : super(key: key);
  final String label;
  final double price;
  final double? width;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '\$$price',
            style: AppTextStyle.price,
          ),
          Button(
            label: label,
            width: width ?? AppSize.s172,
            height: AppSize.s54,
            colorBackgroud: ColorsGlobal.globalPink,
            colorLabel: ColorsGlobal.white,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
