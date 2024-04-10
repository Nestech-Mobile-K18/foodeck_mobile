import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final bool obscureText;
  final String errorText;
  final dynamic onTapObscureText;
  final dynamic onChanged;
  final String? initialText;
  final String? hintText;
  final TextInputType? keyboardType;
  final double? width;
  final double? height;
  final BoxBorder? border;
  final Widget? suffixIcon;
  final dynamic onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;

  final List<TextInputFormatter>? textInputFormatter;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.label,
    required this.obscureText,
    required this.errorText,
    this.onTapObscureText,
    this.onChanged,
    this.initialText,
    this.textInputFormatter,
    this.keyboardType,
    this.hintText,
    this.width,
    this.height,
    this.border,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.contentPadding,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  // Use it to change color for border when textFiled in focus
  final FocusNode _focusNode = FocusNode();

  // Color for border & label
  Color _focusColor = AppColor.grey1;

  //
  @override
  void initState() {
    super.initState();
    // Change color for border if focus was changed
    _focusNode.addListener(() {
      setState(() {
        _focusColor = _focusNode.hasFocus ? AppColor.primary : AppColor.grey1;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }
  //

  ///
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: widget.width ?? 328,
          height: widget.height ?? 74,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.white,
            border: widget.border ?? Border.all(width: 1, color: _focusColor),
          ),
          child: TextFormField(
            onFieldSubmitted: widget.onFieldSubmitted,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            controller: widget.controller,
            initialValue: widget.initialText,
            inputFormatters: widget.textInputFormatter,
            keyboardType: widget.keyboardType,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
            decoration: InputDecoration(
                errorStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.red,
                ),
                labelText: widget.label,
                labelStyle: GoogleFonts.inter(
                  color: _focusColor,
                ),
                hintText: widget.hintText,
                hintStyle: TextStyle(color: AppColor.grey2),
                suffixIcon: widget.suffixIcon,

                // widget.label == "Password" &&
                //         widget.controller!.text.isNotEmpty
                //     ? InkWell(
                //         onTap: widget.onTapObscureText,
                //         child: const Icon(Icons.remove_red_eye_outlined))
                //     : null,
                suffixIconColor: AppColor.grey1,
                contentPadding: widget.contentPadding ??
                    const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                border: InputBorder.none),
          ),
        ),
        SizedBox(
          height: 16,
          child: Text(
            widget.errorText,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColor.red,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
