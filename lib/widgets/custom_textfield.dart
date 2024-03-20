import 'package:flutter/material.dart';
import 'package:template/resources/colors.dart';
import 'package:template/widgets/custom_text.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? title;
  final bool? obscureText;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.title,
    this.obscureText,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    CustomTextFieldManager.register(this);
  }

  @override
  void dispose() {
    CustomTextFieldManager.unregister(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color:
              isSelected ? ColorsGlobal.globalPink : ColorsGlobal.dividerGrey,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              title: widget.title ?? 'Title',
              color:
                  isSelected ? ColorsGlobal.globalPink : ColorsGlobal.textGrey,
              size: 16,
              fontWeight: FontWeight.w400,
            ),
            TextField(
              onTap: () {
                setState(() {
                  // Set the current CustomTextField as selected
                  isSelected = true;
                  // Reset all other CustomTextFields
                  CustomTextFieldManager.resetAllExcept(this);
                });
              },
              controller: widget.controller,
              textAlign: TextAlign.left,
              obscureText: widget.obscureText ?? false,
              decoration: InputDecoration(
                hintText: widget.hintText ?? '',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFieldManager {
  static List<_CustomTextFieldState> _customTextFields = [];

  static void register(_CustomTextFieldState customTextFieldState) {
    _customTextFields.add(customTextFieldState);
  }

  static void unregister(_CustomTextFieldState customTextFieldState) {
    _customTextFields.remove(customTextFieldState);
  }

  static void resetAllExcept(_CustomTextFieldState currentTextField) {
    // Iterate through all CustomTextFields
    for (var textField in _customTextFields) {
      // If the current text field is not the selected one, reset its state
      if (textField != currentTextField) {
        textField.setState(() {
          textField.isSelected = false;
        });
      }
    }
  }
}
