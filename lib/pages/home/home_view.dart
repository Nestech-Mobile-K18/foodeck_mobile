import 'package:flutter/material.dart';
import 'package:template/pages/home/home_view_model.dart';
import 'package:template/pages/home/widgets/home_banner_slider.dart';
import 'package:template/pages/home/widgets/home_bar.dart';
import 'package:template/pages/home/widgets/home_categoties.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';

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
    setState(() {
      _address =
          address ?? 'Unknown'; // Cập nhật địa chỉ và xử lý trường hợp null
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsGlobal.globalWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Homebar(address: _address),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HomeCategogies(
                  imgString: MediaRes.food,
                  headerText: StringExtensions.food,
                  contentText: StringExtensions.contentFood,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeCategogies(
                      imgString: MediaRes.grocery,
                      headerText: StringExtensions.food,
                      contentText: StringExtensions.contentFood,
                      heightCard: 180,
                      widthCard: 180,
                    ),
                    HomeCategogies(
                      imgString: MediaRes.deserts,
                      headerText: StringExtensions.food,
                      contentText: StringExtensions.contentFood,
                      heightCard: 180,
                      widthCard: 180,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            HomeBannerSlider(),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: StringExtensions.deals,
                    color: ColorsGlobal.globalBlack,
                    fontWeight: FontWeight.w700,
                  ),
                  Icon(Icons.arrow_forward)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
