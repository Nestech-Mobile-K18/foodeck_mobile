import 'package:flutter/material.dart';
import 'package:template/pages/map/views/add_location_view.dart';
import 'package:template/pages/map/vm/map_view_model.dart';
import 'package:template/pages/map/widget/bottom_sheet.dart';

import 'package:template/pages/map/widget/show_map.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';

class MapBoxView extends StatefulWidget {
  const MapBoxView({Key? key});

  @override
  State<MapBoxView> createState() => _MapBoxViewState();
}

class _MapBoxViewState extends State<MapBoxView> with TickerProviderStateMixin {
  final MapViewModel _viewModel = MapViewModel();
  Map<String, String?>? _selectedItemData; // Update to hold selected item data
  int selectedIndex = 0;
  bool _showBottomSheet = false;
  void _closeBottomSheet() {
    setState(() {
      _showBottomSheet = false;
    });
  }

  void updateSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              title: StringExtensions.myLocations,
              size: 17,
              fontWeight: FontWeight.w700,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddLocationView()));
              },
              child: const CustomText(
                title: StringExtensions.add,
                color: ColorsGlobal.globalPink,
                size: 13,
              ),
            )
          ],
        ),
      ),
      body: ShowMap(
        mapController: _viewModel.mapController,
        isShowLocationCard: true,
        onLongPressLocationCard: (selectedItems, index) {
          if (ModalRoute.of(context) != null) {
            setState(() {
              _selectedItemData = selectedItems; // Update selected item data
              _showBottomSheet =
                  true; // Only set the bottom page if the parent widget still exists
              updateSelectedIndex(index);
            });
          }
        },
      ),
      bottomSheet: _showBottomSheet
          ? BottomSheet(
              onClosing: _closeBottomSheet,
              backgroundColor: ColorsGlobal.globalWhite,
              enableDrag: true,
              animationController: BottomSheet.createAnimationController(this),
              builder: (BuildContext context) {
                return BottomSheetCustom(
                  onEditing: (typeAdress, address, addressInstructions) {
                    _viewModel.updateLocationOnSupabase(address, typeAdress,
                        addressInstructions, selectedIndex);
                    _closeBottomSheet();
                  },
                  onDeleting: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(StringExtensions.doYouWantDelete),
                          content: const Text(StringExtensions.areYouSure),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                String? address = _selectedItemData!['address'];
                                String? typeAddress =
                                    _selectedItemData!['type_address'];
                                String? addressInstrunctions =
                                    _selectedItemData!['address_instructions'];
                                await _viewModel.deleteLocationOnSupabase(
                                    address!,
                                    typeAddress!,
                                    addressInstrunctions,
                                    context);
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                                _closeBottomSheet();
                              },
                              child: const Text(StringExtensions.oke),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text(StringExtensions.cancel),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  bindingData: _selectedItemData,
                );
              },
            )
          : null,
    );
  }
}
