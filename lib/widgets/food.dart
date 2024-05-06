import 'package:template/pages/export.dart';

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
          builder: (context) => OrderInfoVew(id: id),
          settings: RouteSettings(name: RouteName.orderInfo, arguments: id)),
    );
   
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleOrderInfo(widget.id),
      child: Row(
        children: [
          Container(
            height: 100.dp,
            width: 100.dp,
            child: Stack(
              fit: StackFit.loose,
              children: [
                Positioned(
                  right: 15.dp,
                  top: 15.dp,
                  child: Container(
                    width: 64.dp,
                    height: 64.dp,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            16) // Adjust the radius as needed
                        ),
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
                        width: 25.dp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0.dp,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Padding(
                            padding: EdgeInsets.all(2.dp),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                widget.quanity.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
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
            width: 16.dp,
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.foodName,
                  style: TextStyle(fontSize: 17.dp, color: Colors.black),
                ),
                Text(
                  widget.description!,
                  style: TextStyle(fontSize: 15.dp, color: Colors.grey),
                ),
                Text(
                  '\$${widget.price}',
                  style: TextStyle(
                      fontSize: 15.dp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          SizedBox(
            width: 16.dp,
          ),
          if (widget.quanity != 0)
            Expanded(
                child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.clear),
            ))
        ],
      ),
    );
  }
}
