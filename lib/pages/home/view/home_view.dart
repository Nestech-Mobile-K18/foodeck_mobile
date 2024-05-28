import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/pages/food_menu/views/food_menu_view.dart';
import 'package:template/pages/home/vm/home_view_model.dart';
import 'package:template/pages/home/widgets/home_banner_slider.dart';
import 'package:template/pages/home/widgets/home_bar.dart';
import 'package:template/pages/home/widgets/home_deals.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_floating_action_button_location.dart';
import 'package:template/widgets/loading_indicator.dart';

import '../../cart/views/cart_view.dart';
import '../../list_menu/view/list_menu_view.dart';
import '../widgets/home_categories.dart';
import '../widgets/home_explore.dart';

class HomeView extends StatefulWidget {
  final Function(String)? userAddress;

  const HomeView({super.key, this.userAddress});

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
    _updateMenuData();
    _updateCartItemCount();
  }

  Future<void> _updateCartItemCount() async {
    final itemCount = await _viewModel.countCartItems();
    setState(() {
       itemCount;
    });
  }

  void _updateAddress(String? address) {
    if (mounted) {
      setState(() {
        _address = address ?? '';
        widget.userAddress?.call(_address);
      });
    }
  }

  Future<void> _updateMenuData() async {
    setState(() {
      menuData = _viewModel.responseListMenu();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.onAddressReceived = null;
    _viewModel.requestPermissionLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _viewModel,
      child: Scaffold(

        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CartView()));
            if (result == true) {
              _updateCartItemCount();
            }
          },
          shape: const CircleBorder(),
          backgroundColor: ColorsGlobal.globalPink,
          tooltip: 'check cart',
          child: Stack(
            children: [
              Image.asset(
                MediaRes.cart,
                fit: BoxFit.fill,
                width: 30,
                height: 30,
              ),
              Positioned(
                left: 0,
                bottom: -6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorsGlobal.globalBlack,
                  ),
                  child: FutureBuilder<int>(
                    future: _viewModel.countCartItems(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          snapshot.data.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: CustomFloatingActionButtonLocation(),
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorsGlobal.globalWhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              HomeBar(address: _address),
              const SizedBox(height: 20),
              const HomeCategories(),
              const SizedBox(height: 40),
              const HomeBannerSlider(),
              const SizedBox(height: 40),
              FutureBuilder(
                future: menuData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return HomeDeals(
                      userAddress: _address,
                      onTapShowListMenu: () async {
                        bool shouldUpdateMenu = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ListMenuView(
                              userAddress: _address,
                            ),
                          ),
                        );
                        if (shouldUpdateMenu == true) {
                          _updateMenuData();
                        }
                      },
                      data: snapshot.data,
                      onDealSelected: (data) async {
                        bool shouldUpdateMenu = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodMenuView(
                              bindingData: data,
                            ),
                          ),
                        );
                        if (shouldUpdateMenu == true) {
                          _updateMenuData();
                        }
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 40),
              const HomeExplore(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}