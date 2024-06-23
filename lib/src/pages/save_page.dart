import 'package:template/src/pages/export.dart';

class SavePage extends StatefulWidget {
  const SavePage({Key? key}) : super(key: key);

  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  late final List<Item> _saves;
  @override
  void initState() {
    _saves = saves;
    super.initState();
  }

  Future<void> _handleRestaurant(int id) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RestaurantPage(
                id: id,
                nameRestaurant: '',
                nameAddress: '',
                rate: 0,
                time: 0,
                timeUnit: '',
                distance: 0, disUnit: '',
              ),
          settings: RouteSettings(name: RouteName.restaurant, arguments: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p24, vertical: AppPadding.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppStrings.save} (${_saves.length})',
            style: AppTextStyle.title,
          ),
          SizedBox(
            height: AppSize.s12,
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
