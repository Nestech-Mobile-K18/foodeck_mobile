import 'package:template/pages/export.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    Key? key,
    required this.orderSummary,
    required this.subTotal,
    required this.fee,
    required this.vat,
    required this.coupon,
  }) : super(key: key);
  final List<OrderSummary> orderSummary;
  final double subTotal;
  final double fee;
  final double vat;
  final double coupon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.orderSummary, style: AppTextStyle.title),
        SizedBox(
          height: AppSize.s5,
        ),
        ListView.builder(
            padding: EdgeInsets.only(bottom: AppPadding.p0),
            physics:
                const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: orderSummary.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTileTheme(
                    contentPadding: EdgeInsets.zero,
                    child: ListTile(
                        trailing: Text(
                          "\$${orderSummary[index].price}",
                          style: TextStyle(
                              color: ColorsGlobal.grey, fontSize: AppSize.s17),
                        ),
                        title: Text(
                            "${orderSummary[index].quanity}x ${orderSummary[index].foodName}",
                            style: AppTextStyle.label)),
                  ),
                  const Divider(),
                ],
              );
            }),
        ListTileTheme(
          contentPadding: EdgeInsets.zero,
          child: ListTile(
              trailing: Text(
                "\$$subTotal",
                style: AppTextStyle.value,
              ),
              title: Text(AppStrings.subtotal, style: AppTextStyle.label)),
        ),
        const Divider(),
        ListTileTheme(
          contentPadding: EdgeInsets.zero,
          child: ListTile(
              trailing: Text(
                "\$$fee",
                style: AppTextStyle.value,
              ),
              title: Text(AppStrings.deliveryFee, style: AppTextStyle.label)),
        ),
        const Divider(),
        ListTileTheme(
          contentPadding: EdgeInsets.zero,
          child: ListTile(
              trailing: Text(
                "\$$vat",
                style: AppTextStyle.value,
              ),
              title: Text(AppStrings.vat, style: AppTextStyle.label)),
        ),
        const Divider(),
        ListTileTheme(
          contentPadding: EdgeInsets.zero,
          child: ListTile(
              trailing: Text(
                "-\$$coupon",
                style: AppTextStyle.textGreen,
              ),
              title: Text(AppStrings.coupon, style: AppTextStyle.label)),
        )
      ],
    );
  }
}
