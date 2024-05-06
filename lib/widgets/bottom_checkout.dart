import 'package:template/pages/export.dart';

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
      padding: EdgeInsets.all(24.0.dp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '\$$price',
            style: TextStyle(fontSize: 28.dp, fontWeight: FontWeight.w900),
          ),
          Button(
            label: label,
            width: width ?? 172.dp,
            height: 54.dp,
            colorBackgroud: ColorsGlobal.globalPink,
            colorLabel: Colors.white,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
