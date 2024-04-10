import 'package:flutter/material.dart';
import 'package:template/pages/map/widget/search_card.dart';
import 'package:template/widgets/research_bar.dart';

import '../../../resources/const.dart';
import '../../../widgets/custom_text.dart';
import '../vm/map_view_model.dart';
import '../widget/show_map.dart';

class AddLocationView extends StatefulWidget {
  const AddLocationView({super.key});

  @override
  State<AddLocationView> createState() => _AddLocationViewState();
}

class _AddLocationViewState extends State<AddLocationView> {
  final MapViewModel _viewModel = MapViewModel();
  bool _isLoadingMore = false;
  ScrollController _scrollController = ScrollController();

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
      appBar: AppBar(
        centerTitle: false,
        title: CustomText(
          title: StringExtensions.addLocation,
          size: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: ShowMap(
        mapController: _viewModel.mapController,
        onTap: _viewModel.targetUserLocation,
        isShowLocationCard: false,
      ),
      backgroundColor: ColorsGlobal.globalWhite,
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        height: Responsive.screenHeight(context) * 0.5,
        width: double.infinity,
        decoration: BoxDecoration(
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
                _viewModel.searchPlaces(value);
              },
              hintText: 'Search Location',
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
                  if (!_viewModel.isLoading && !_viewModel.isSearching) {
                    if (index < _viewModel.searchResults.length) {
                      return SearchCard(
                        address: _viewModel.searchResults[index]['place_name'],
                        nameOfPlace: _viewModel.searchResults[index]
                            ['place_type'],
                      );
                    }
                  }

                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
