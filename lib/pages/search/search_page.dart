import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  String searchText = '';
  List<RestaurantModel> filterItems = [];

  void search(String value) {
    setState(() {
      searchText = value;
      myFilterItems();
    });
  }

  void myFilterItems() {
    if (searchText.isEmpty) {
      filterItems = [];
    } else {
      filterItems = RestaurantData.restaurant
          .where((element) =>
              element.shopName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  @override
  void dispose() {
    searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: AppColor.globalPink,
        title: CupertinoSearchTextField(
          controller: searchController,
          backgroundColor: Colors.white,
          onChanged: search,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView.builder(
          clipBehavior: Clip.none,
          itemCount: filterItems.length,
          itemBuilder: (context, index) => Column(
            children: [
              BannerItems(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                foodImage: filterItems[index].image,
                deliveryTime: '${filterItems[index].deliveryTime} mins',
                shopName: filterItems[index].shopName,
                shopAddress: filterItems[index].address,
                rateStar: '${filterItems[index].rate}',
                badge: const SizedBox(),
              ),
              filterItems.length - 1 == index
                  ? const SizedBox()
                  : const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
