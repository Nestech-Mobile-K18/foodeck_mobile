import 'package:flutter/material.dart';
import 'package:template/pages/home/vm/home_view_model.dart';
import 'package:template/pages/home/widgets/home_banner_slider.dart';
import 'package:template/pages/home/widgets/home_bar.dart';
import 'package:template/pages/home/widgets/home_deals.dart';
import 'package:template/pages/home/widgets/home_card.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_floating_action_button_location.dart';

import '../widgets/home_categories.dart';
import '../widgets/home_explore.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _viewModel = HomeViewModel();
  String _address = '';

  @override
  void initState() {
    super.initState();
    _viewModel.requestPermissionLocation(context);
    _viewModel.onAddressReceived = _updateAddress;
  }

  void _updateAddress(String? address) {
    if (mounted) {
      // Kiểm tra xem widget có còn được mounted không trước khi gọi setState
      setState(() {
        _address = address ?? 'Unknown';
      });
    }
  }

  @override
  void dispose() {
    // Gỡ bỏ callback khi widget bị dispose
    _viewModel.onAddressReceived = null;
    _viewModel.requestPermissionLocation(context);
    super.dispose();
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
      body: const SingleChildScrollView(
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
            HomeDeals(),
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
