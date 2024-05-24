import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/resources/colors.dart';
import 'package:template/widgets/custom_text.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? title;
  final bool? obscureText;
  final TextInputType? textInputType;
  final Color? hintTextColor;
  final bool? disableTitle;
  final Widget? iconSuffit;
  final bool? readOnly;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onEditingComplete;

  const CustomTextField(
      {super.key,
      this.hintText,
      this.controller,
      this.title,
      this.readOnly,
      this.obscureText,
      this.iconSuffit,
      this.disableTitle,
      this.hintTextColor,
      this.onChanged,
      this.onSubmitted,
      this.onEditingComplete,
      this.inputFormatters,
      this.textInputType});

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
            widget.disableTitle == true ? Container() :
            CustomText(
              title: widget.title ?? 'Title',
              color:
                  isSelected ? ColorsGlobal.globalPink : ColorsGlobal.textGrey,
              size: 16,
              fontWeight: FontWeight.w400,
            ),
            TextField(
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              onEditingComplete: widget.onEditingComplete,
              onTap: () {
                setState(() {
                  // Set the current CustomTextField as selected
                  isSelected = true;
                  // Reset all other CustomTextFields
                  CustomTextFieldManager.resetAllExcept(this);
                });
              },
              keyboardType: widget.textInputType ?? TextInputType.text,
              controller: widget.controller,
              textAlign: TextAlign.left,
              readOnly: widget.readOnly ?? false,
              obscureText: widget.obscureText ?? false,
              decoration: InputDecoration(
                  hintText: widget.hintText ?? '',
                  hintStyle: TextStyle(
                      color: widget.hintTextColor ?? ColorsGlobal.textGrey),
                  border: InputBorder.none,
                  suffixIcon: widget.iconSuffit),
              inputFormatters: widget.inputFormatters,
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
