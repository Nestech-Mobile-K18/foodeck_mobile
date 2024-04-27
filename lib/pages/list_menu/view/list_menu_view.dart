import 'package:flutter/material.dart';
import 'package:template/pages/list_menu/widgets/item_menu.dart';
import 'package:template/resources/export.dart';

import '../../../resources/responsive.dart';
import '../../../widgets/loading_indicator.dart';
import '../../food_menu/views/food_menu_view.dart';
import '../vm/list_menu_view_model.dart';

class ListMenuView extends StatefulWidget {
  final String? userAddress;
  const ListMenuView({super.key, this.userAddress});

  @override
  State<ListMenuView> createState() => _ListMenuViewState();
}

class _ListMenuViewState extends State<ListMenuView> {
  Future<List<Map<String, dynamic>>?>? menuData;
  final ListMenuViewModel _viewModel = ListMenuViewModel();

  @override
  void initState() {
    super.initState();
    menuData = _viewModel.responseListMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Responsive.screenHeight(context) * 0.2),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(MediaRes.bannerMenu),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 35,
                left: 5,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: ColorsGlobal.globalWhite,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: menuData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ItemMenu(
                userAddress: widget.userAddress,
                data: snapshot.data,
                onDealSelected: (data) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FoodMenuView(
                      bindingData: data,
                    ),
                  ));
                },
              );
            }
          },
        ),
      ),
    );
  }
}
