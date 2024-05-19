import 'package:template/pages/export.dart';

class FoodRecentOrder extends StatelessWidget {
  const FoodRecentOrder(
      {Key? key,
      required this.id,
      required this.image,
      required this.price,
      required this.name,
      this.height})
      : super(key: key);
  final String id;
  final String image;
  final double price;
  final String name;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: Container(
            height: height,
            width: double.infinity,
            padding: EdgeInsets.all(AppPadding.p24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r16),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          name,
          textAlign: TextAlign.right,
          style: AppTextStyle.title,
        ),
        SizedBox(
          height: AppSize.s8,
        ),
        Text(
          '\$ ${price.toString()}',
          textAlign: TextAlign.right,
          style: TextStyle(
              color: ColorsGlobal.grey,
              fontSize: AppSize.s15,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
