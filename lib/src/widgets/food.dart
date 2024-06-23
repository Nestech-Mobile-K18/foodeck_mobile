import 'package:template/src/pages/export.dart';

class Food extends StatefulWidget {
  const Food(
      {Key? key,
      this.image,
      required this.foodName,
      this.description,
      required this.price,
      required this.quanity,
      required this.id})
      : super(key: key);
  final String? image;
  final String foodName;
  final String? description;
  final double price;
  final int quanity;
  final String id;
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  Future<void> _handleOrderInfo(String id) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OrderInfoPage(id: id),
          settings: RouteSettings(name: RouteName.orderInfo, arguments: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleOrderInfo(widget.id),
      child: Row(
        children: [
          SizedBox(
            height: AppSize.s100,
            width: AppSize.s100,
            child: Stack(
              fit: StackFit.loose,
              children: [
                Positioned(
                  right: AppSize.s15,
                  top: AppSize.s15,
                  child: Container(
                    width: AppSize.s64,
                    height: AppSize.s64,
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(AppRadius.r16)),
                    child: Image(
                      image: AssetImage(widget.image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (widget.quanity != 0)
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: AppSize.s25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ColorsGlobal.white,
                            width: AppSize.s2,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: ColorsGlobal.black,
                          child: Padding(
                            padding: EdgeInsets.all(AppPadding.p2),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                widget.quanity.toString(),
                                style: const TextStyle(
                                    color: ColorsGlobal.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ))
              ],
            ),
          ),
          SizedBox(
            width: AppSize.s16,
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.foodName,
                  style: TextStyle(
                      fontSize: AppSize.s17, color: ColorsGlobal.black),
                ),
                Text(
                  widget.description!,
                  style: TextStyle(
                      fontSize: AppSize.s15, color: ColorsGlobal.grey),
                ),
                Text(
                  '\$${widget.price}',
                  style: AppTextStyle.priceSmall,
                )
              ],
            ),
          ),
          SizedBox(
            width: AppSize.s16,
          ),
          if (widget.quanity != 0)
            Expanded(
                child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.clear),
            ))
        ],
      ),
    );
  }
}
