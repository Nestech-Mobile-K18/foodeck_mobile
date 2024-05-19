import 'package:template/pages/export.dart';

class BillDetailView extends StatelessWidget {
  const BillDetailView({Key? key, required this.billDetail}) : super(key: key);
  final BillDetail billDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        title: billDetail.restaurant,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Order Summary
            Padding(
                padding: EdgeInsets.only(
                    top: AppPadding.p24,
                    right: AppPadding.p24,
                    left: AppPadding.p24,
                    bottom: AppPadding.p8),
                child: OrderSummaryWidget(
                  orderSummary: billDetail.orderSummary,
                  coupon: billDetail.coupon!,
                  fee: billDetail.fee!,
                  subTotal: billDetail.subTotal,
                  vat: billDetail.vat!,
                )),
            // Delivery Address
            Divider(
              color: ColorsGlobal.grey3,
              thickness: AppSize.s8,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: AppPadding.p24,
                  right: AppPadding.p24,
                  left: AppPadding.p24,
                  bottom: AppPadding.p8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.deliveryAddress, style: AppTextStyle.title),
                  SizedBox(
                    height: AppSize.s5,
                  ),
                  Text(billDetail.deliveryAddress,
                      style: AppTextStyle.decription),
                  SizedBox(
                    height: AppSize.s5,
                  ),
                ],
              ),
            ),
            //Delivery Instructions
            Divider(
              color: ColorsGlobal.grey3,
              thickness: AppSize.s8,
            ),

            Padding(
              padding: EdgeInsets.only(
                  top: AppPadding.p24,
                  right: AppPadding.p24,
                  left: AppPadding.p24,
                  bottom: AppPadding.p8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.deliveryInstructions,
                      style: AppTextStyle.title),
                  SizedBox(
                    height: AppSize.s5,
                  ),
                  Text(billDetail.deliveryInstruction!,
                      style: AppTextStyle.decription),
                  SizedBox(
                    height: AppSize.s5,
                  ),
                ],
              ),
            ),
            //Payment Method
            Divider(
              color: ColorsGlobal.grey3,
              thickness: AppSize.s8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p24, vertical: AppPadding.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.paymentMethod, style: AppTextStyle.title),
                  SizedBox(
                    height: AppSize.s5,
                  ),
                  SizedBox(
                    height: AppSize.s200,
                    child: SizedBox(
                      height: AppSize.s200,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadius.r16),
                          image: const DecorationImage(
                            image: AssetImage(MediaRes.card1),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: AppSize.s328,
                        margin: EdgeInsets.symmetric(horizontal: AppMargin.m4),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p24, vertical: AppPadding.p12),
              child: Button(
                label: 'Cancel Order',
                width: double.infinity,
                height: AppSize.s62,
                colorBackgroud: ColorsGlobal.globalPink,
                colorLabel: ColorsGlobal.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
