import 'package:flutter/material.dart';
import 'package:template/resources/const.dart';

import '../../../widgets/custom_text.dart';

class BottomSheetCustom extends StatefulWidget {
  final Map<String, String?>? bindingData;
  final VoidCallback? onDeleting;
  final Function(String, String, String)? onEditing;
  const BottomSheetCustom(
      {super.key, this.bindingData, this.onDeleting, this.onEditing});

  @override
  State<BottomSheetCustom> createState() => _BottomSheetCustomState();
}

class _BottomSheetCustomState extends State<BottomSheetCustom> {
  late TextEditingController nameOfPlaceController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController addressInstructionsController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    nameOfPlaceController =
        TextEditingController(text: widget.bindingData?['type_address']);
    addressController =
        TextEditingController(text: widget.bindingData?['address']);
    addressInstructionsController =
        TextEditingController(text: 'Near empty plot');
  }

  @override
  void dispose() {
    nameOfPlaceController.dispose();
    addressController.dispose();
    addressInstructionsController.dispose();
    super.dispose();
  }

  bool isEditing = false;
  bool isDone = false;
  bool isEditingItem = false;
  @override
  Widget build(BuildContext context) {
    String? fullAddress = widget.bindingData?['address'];
    List<String>? addressParts = fullAddress?.split(', ');
    String city = '';
    String area = '';

    if (addressParts != null && addressParts.length >= 3) {
      city = addressParts[addressParts.length - 2];
      area = addressParts[0];
    }

    return SizedBox(
      height: Responsive.screenHeight(context) * 0.8,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              width: Responsive.screenWidth(context) * 0.2,
              height: 5,
              decoration: BoxDecoration(
                color: ColorsGlobal.globalGrey5,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(
                    MediaRes.location,
                    color: ColorsGlobal.globalBlack,
                    height: 30,
                    width: 30,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        title: widget.bindingData?['type_address'] ?? '',
                        color: ColorsGlobal.globalBlack,
                        size: 15,
                      ),
                      CustomText(
                        maxLine: 2,
                        title: widget.bindingData?['address'] ?? '',
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        color: ColorsGlobal.globalBlack,
                        size: 15,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (isEditing) {
                        isEditing = false;
                        isDone = true;
                      } else {
                        isEditing = true;
                        isDone = false;
                      }
                    });
                    if (isDone) {
                      // Call the onEditing function and pass input values ​​from the controllers
                      widget.onEditing?.call(
                        nameOfPlaceController.text,
                        addressController.text,
                        addressInstructionsController.text,
                      );
                    }
                  },
                  icon: isEditing == false
                      ? const Icon(Icons.mode_edit_outlined)
                      : const Icon(
                          Icons.done_outline_sharp,
                          color: ColorsGlobal.globalGreen,
                        ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              thickness: Responsive.screenHeight(context) * 0.02,
              color: ColorsGlobal.dividerGrey,
            ),
            Column(
              children: [
                ListTile(
                  title: const Text(
                    StringExtensions.nameOfPlace,
                    style: TextStyle(
                      color: ColorsGlobal.textGrey,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: TextFormField(
                    controller: nameOfPlaceController,
                    readOnly: !isEditing,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: ColorsGlobal.dividerGrey,
                ),
                ListTile(
                  title: const CustomText(
                    title: StringExtensions.city,
                    color: ColorsGlobal.textGrey,
                    size: 15,
                  ),
                  subtitle: CustomText(
                    title: city,
                    color: ColorsGlobal.globalBlack,
                    size: 15,
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: ColorsGlobal.dividerGrey,
                ),
                ListTile(
                  title: const CustomText(
                    title: StringExtensions.area,
                    color: ColorsGlobal.textGrey,
                    size: 15,
                  ),
                  subtitle: CustomText(
                    title: area,
                    color: ColorsGlobal.globalBlack,
                    size: 15,
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: ColorsGlobal.dividerGrey,
                ),
                ListTile(
                  title: const CustomText(
                    title: StringExtensions.address,
                    color: ColorsGlobal.textGrey,
                    size: 15,
                  ),
                  subtitle: TextFormField(
                    controller: addressController,
                    readOnly: !isEditing,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: ColorsGlobal.dividerGrey,
                ),
                ListTile(
                  title: const CustomText(
                    title: StringExtensions.addressInstructions,
                    color: ColorsGlobal.textGrey,
                    size: 15,
                  ),
                  subtitle: TextFormField(
                    controller: addressInstructionsController,
                    readOnly: !isEditing,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: ColorsGlobal.dividerGrey,
                ),
                ListTile(
                  onTap: widget.onDeleting,
                  title: const CustomText(
                    title: StringExtensions.deleteLocation,
                    color: ColorsGlobal.globalRed,
                    size: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
