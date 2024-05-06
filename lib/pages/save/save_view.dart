import 'package:template/pages/export.dart';

class SaveView extends StatefulWidget {
  const SaveView({Key? key}) : super(key: key);

  @override
  _SaveViewState createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  late final List<Item> _saves;
  @override
  void initState() {
    _saves = saves;
    super.initState();
  }

  Future<void> _handleRestaurant(String id) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RestaurantView(id: id),
          settings: RouteSettings(name: RouteName.restaurant, arguments: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.dp, vertical: 12.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Save (${_saves.length})',
            style: TextStyle(fontSize: 20.dp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12.dp,
          ),
          ListView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _saves.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () => _handleRestaurant(_saves[index].id),
                    child: _saves[index]);
              }),
        ],
      ),
    ));
  }
}
