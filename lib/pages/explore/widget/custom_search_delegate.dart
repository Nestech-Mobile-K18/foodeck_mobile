import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/models/desktop_food.dart';
import 'package:template/pages/explore/widget/banner_items.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/list.dart';

class CustomSearchDelegate extends StatefulWidget {
  const CustomSearchDelegate({super.key});

  @override
  State<CustomSearchDelegate> createState() => _CustomSearchDelegateState();
}

class _CustomSearchDelegateState extends State<CustomSearchDelegate> {
  final searchController = TextEditingController();
  String searchText = '';
  List<DesktopFood> filterItems = [];

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
      filterItems = desktopFood
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
        backgroundColor: globalPink,
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
                foodImage: filterItems[index].foodOrder,
                deliveryTime: filterItems[index].time,
                shopName: filterItems[index].shopName,
                shopAddress: filterItems[index].place,
                rateStar: filterItems[index].vote,
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
