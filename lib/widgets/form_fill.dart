import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/text_styles.dart';

class CustomFormFill extends StatefulWidget {
  const CustomFormFill({
    super.key,
    this.textInputType,
    this.function,
    this.textEditingController,
    this.errorText,
    this.hintText,
    this.labelText,
    this.labelColor,
    this.icons,
    this.obscureText,
    this.boxSize,
    this.borderColor,
    this.textAlign,
    this.focusNode,
    this.padding,
    this.textInputFormatter,
  });
  final TextInputType? textInputType;
  final Function(String)? function;
  final TextEditingController? textEditingController;
  final String? errorText;
  final String? hintText;
  final String? labelText;
  final Color? labelColor;
  final Color? borderColor;
  final IconButton? icons;
  final bool? obscureText;
  final BoxConstraints? boxSize;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? textInputFormatter;
  final EdgeInsets? padding;
  final FocusNode? focusNode;
  @override
  State<CustomFormFill> createState() => _CustomFormFillState();
}

class _CustomFormFillState extends State<CustomFormFill> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      inputFormatters: widget.textInputFormatter,
      textAlign: widget.textAlign ?? TextAlign.start,
      obscureText: widget.obscureText ?? false,
      keyboardType: widget.textInputType,
      onChanged: widget.function,
      style: inter.copyWith(fontSize: 17),
      controller: widget.textEditingController,
      decoration: InputDecoration(
          suffixIcon: widget.icons,
          constraints: widget.boxSize ?? const BoxConstraints(maxWidth: 328),
          labelText: widget.labelText,
          labelStyle: inter.copyWith(fontSize: 12, color: Colors.grey),
          floatingLabelStyle:
              inter.copyWith(fontSize: 12, color: widget.labelColor),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorText: widget.errorText,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.grey)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red)),
          contentPadding: widget.padding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
              borderRadius: BorderRadius.circular(16)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: globalPink),
              borderRadius: BorderRadius.circular(16)),
          hintText: widget.hintText,
          hintStyle: inter.copyWith(fontSize: 17, color: Colors.grey),
          helperText: ''),
    );
  }
}
