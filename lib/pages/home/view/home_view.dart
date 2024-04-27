import 'package:flutter/material.dart';
import 'package:template/pages/food_menu/views/food_menu_view.dart';
import 'package:template/pages/home/vm/home_view_model.dart';
import 'package:template/pages/home/widgets/home_banner_slider.dart';
import 'package:template/pages/home/widgets/home_bar.dart';
import 'package:template/pages/home/widgets/home_deals.dart';
import 'package:template/pages/home/widgets/home_card.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_floating_action_button_location.dart';
import 'package:template/widgets/loading_indicator.dart';

import '../../list_menu/view/list_menu_view.dart';
import '../widgets/home_categories.dart';
import '../widgets/home_explore.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _viewModel = HomeViewModel();
  String _address = '';
  Future<List<Map<String, dynamic>>?>? menuData;
  Future<Map<String, dynamic>>? selectTime;

  @override
  void initState() {
    super.initState();
    _viewModel.requestPermissionLocation(context);
    _viewModel.onAddressReceived = _updateAddress;
    menuData = _viewModel.responseListMenu();
  }

  void _updateAddress(String? address) {
    if (mounted) {
      setState(() {
        _address = address ?? '';
      });
    }
  }

  @override
  void dispose() {
    
    super.dispose();
    _viewModel.onAddressReceived = null;
    _viewModel.requestPermissionLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(context, _address),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {},
        // ignore: sort_child_properties_last
        child: Image.asset(
          MediaRes.cart,
          fit: BoxFit.fill,
          width: 30,
          height: 30,
        ),
        shape: const CircleBorder(),
        backgroundColor: ColorsGlobal.globalPink,
        tooltip: 'check cart',
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(),
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsGlobal.globalWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            HomeCategories(),
            SizedBox(
              height: 40,
            ),
            HomeBannerSlider(),
            SizedBox(
              height: 40,
            ),
            FutureBuilder(
              future: menuData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return HomeDeals(
                    userAddress: _address,
                    onTapShowListMenu: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ListMenuView(
                                userAddress: _address,
                              )));
                    },
                    data: snapshot.data,
                    onDealSelected: (data) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FoodMenuView(
                          bindingData: data,
                        ),
                      ));
                    },
                  );
                  ;
                }
              },
            ),
            SizedBox(
              height: 40,
            ),
            HomeExplore(),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
