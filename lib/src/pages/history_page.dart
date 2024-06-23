
import 'package:template/src/pages/export.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({ Key? key }) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
 late final List<FoodRecentOrder> _foodRecentOrders;
  late final List<Bill> _bills;
  late final BillDetail _billDetail;

  Future<void> _handleBillDetail(BillDetail billDetail) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BillDetailPage(
                billDetail: billDetail,
              ),
          settings:
              RouteSettings(name: RouteName.billDetail, arguments: billDetail)),
    );
  }

  @override
  void initState() {
    _foodRecentOrders = foodRecentOrders;
    _billDetail = billDetail;
    _bills = bills;
    super.initState();
  }

  Future<void> _handleRecentOrder(String id) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OrderInfoPage(id: id),
          settings: RouteSettings(name: RouteName.orderInfo, arguments: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarScreen(
          title: AppStrings.myOrders, ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Recent Order
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p24, vertical: AppPadding.p12),
                  child: Text(
                    AppStrings.recentOrder,
                    style: AppTextStyle.titleSmall,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: AppPadding.p24),
                  height: AppSize.s250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _foodRecentOrders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          width: AppSize.s250,
                          padding: EdgeInsets.only(right: AppPadding.p24),
                          margin:
                              EdgeInsets.symmetric(horizontal: AppMargin.m4),
                          child: InkWell(
                              onTap: () => _handleRecentOrder(
                                  _foodRecentOrders[index].id),
                              child: _foodRecentOrders[index]));
                    },
                  ),
                ),
                Divider(
                  thickness: AppSize.s8,
                ),
                ListView.separated(
                  physics:
                      const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
                  itemCount: _bills.length,
                  shrinkWrap: true,

                  itemBuilder: (context, index) {
                    // return _bills[index];
                    return ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _bills[index].restaurantName,
                                style: AppTextStyle.label,
                              ),
                              Text(
                                _bills[index].date,
                                style: AppTextStyle.labelGrey,
                              )
                            ],
                          ),
                          Text(
                            '\$${_bills[index].total.toString()}',
                            style: AppTextStyle.valueBold,
                          )
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () => _handleBillDetail(_billDetail),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}