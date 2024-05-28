import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:template/pages/map/widget/result_search_card.dart';
import 'package:template/widgets/research_bar.dart';
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
  bool _hasMoreResults =
      true; // Add this variable to check if there are any more results
  LatLng? _onTarget;
  final ScrollController _scrollController = ScrollController();
  LatLng? selectedLocation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    if (!_isLoadingMore && _hasMoreResults) {
      // Add condition `_hasMoreResults`
      setState(() {
        _isLoadingMore = true;
      });
      try {
        await _viewModel.searchPlaces(_viewModel.currentQuery);
      } finally {
        setState(() {
          _isLoadingMore = false;
          _hasMoreResults = _viewModel.searchResults.length >
              5; // Update the value of _hasMoreResults
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
        title: const Text(
          'Add Location',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: ShowMap(
        mapController: _viewModel.mapController,
        isShowLocationCard: false,
        onMarkerSelected: selectedLocation,
        onTarget: _onTarget,
      ),
      backgroundColor: Colors.white,
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            ReSearchBar(
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    _viewModel.searchPlaces(value);
                  } else {
                    _viewModel.searchResults = [];
                  }
                });
              },
              hintText: 'Search location',
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.grey,
              thickness: 10,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _viewModel.searchResults.length > 5
                    ? 5
                    : _viewModel.searchResults.length,
                itemBuilder: (context, index) {
                  return ResultSearchCard(
                    address: _viewModel.searchResults[index]['place_name'],
                    nameOfPlace: _viewModel.searchResults[index]['place_type'],
                    onTap: () async {
                      LatLng? newLocation =
                          await _viewModel.getLocationFromPlaceName(
                              _viewModel.searchResults[index]['place_name']);
                      setState(() {
                        selectedLocation = newLocation;
                        _onTarget = newLocation;
                      });
                    },
                  );
                },
              ),
            ),
            if (_hasMoreResults)
              _isLoadingMore
                  ? const CircularProgressIndicator()
                  : const SizedBox() // Displayed only when results are available and loading
          ],
        ),
      ),
    );
  }
}
