import 'package:flutter/material.dart';
import 'package:template/pages/saved/widgets/item_menu_saved.dart';
import 'package:template/resources/colors.dart';
import 'package:template/widgets/custom_text.dart';

import '../../food_menu/views/food_menu_view.dart';

class SavedView extends StatefulWidget {
  final String? userAddress;
  const SavedView({super.key, this.userAddress});

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  bool shouldUpdateMenu = false;

  @override
  void initState() {
    super.initState();
    _updateSavedMenuData(); // Update the list of saved items when initially opening the SavedView screen
  }

  // Method to update the list of saved items
  void _updateSavedMenuData() async {
    setState(() {
      shouldUpdateMenu = true; // Mark that the list needs to be updated
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsGlobal.globalWhite,
        automaticallyImplyLeading: false,
        title: const CustomText(
          title: 'Saved',
          color: ColorsGlobal.globalBlack,
          size: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: ColorsGlobal.globalWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemMenuSaved(
              key: UniqueKey(), // Key unique to force widget rebuild

              userAddress: widget.userAddress,
              onDealSelected: (data) async {
                final bool updateMenu = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FoodMenuView(
                      bindingData: data,
                    ),
                  ),
                );
                if (updateMenu) {
                  _updateSavedMenuData(); // Call the function to update the list when returning from FoodMenuView
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
