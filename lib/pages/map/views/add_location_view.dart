import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:template/pages/map/widget/result_search_card.dart';
import 'package:template/widgets/research_bar.dart';

import '../../../resources/const.dart';
import '../../../widgets/custom_text.dart';
import '../vm/map_view_model.dart';
import '../widget/show_map.dart';

class AddLocationView extends StatefulWidget {
  const AddLocationView({Key? key});

  @override
  State<AddLocationView> createState() => _AddLocationViewState();
}

class _AddLocationViewState extends State<AddLocationView> {
  final MapViewModel _viewModel = MapViewModel();
  bool _isLoadingMore = false;
  LatLng? _onTarget;
  final ScrollController _scrollController = ScrollController();
  LatLng? selectedLocation;
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Thêm biến này

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _viewModel.cancelDebounce();
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  void _loadMore() async {
    if (!_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      try {
        await _viewModel.searchPlaces(_viewModel.currentQuery);
      } catch (e) {
        print('Error loading more: $e');
      } finally {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        title: const CustomText(
          title: StringExtensions.addLocation,
          size: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: ShowMap(
        mapController: _viewModel.mapController,
        isShowLocationCard: false,
        onMarkerSelected: selectedLocation,
        onTarget: _onTarget,
      ),
      backgroundColor: ColorsGlobal.globalWhite,
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        height: Responsive.screenHeight(context) * 0.4,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: ColorsGlobal.globalWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            ReSearchBar(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _viewModel.searchPlaces(value);
                } else {
                  _viewModel.searchResults = [];
                }
              },
              hintText: StringExtensions.searchLocation,
            ),
            const SizedBox(height: 10),
            const Divider(
              color: ColorsGlobal.dividerGrey,
              thickness: 10,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _viewModel.searchResults.length,
                itemBuilder: (context, index) {
                  return ResultSearchCard(
                    address: _viewModel.searchResults[index]['place_name'],
                    nameOfPlace: _viewModel.searchResults[index]['place_type'],
                    onTap: () async {
                      LatLng? newLocation =
                          await _viewModel.getLocationFromPlaceName(
                              _viewModel.searchResults[index]['place_name']);
                      setState(() {
                        selectedLocation = newLocation; // Update new location
                        _onTarget = newLocation;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
