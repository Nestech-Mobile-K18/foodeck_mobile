import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.icons,
    required this.text,
    required this.color,
    this.borderSide,
    this.heightBox,
    this.widthBox,
    this.paddingLeft,
  });

  final VoidCallback? onPressed;
  final Widget? icons;
  final Text text;
  final Color color;
  final BorderSide? borderSide;
  final double? heightBox;
  final double? widthBox;
  final double? paddingLeft;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ElevatedButton.icon(
        onPressed: widget.onPressed,
        label: widget.text,
        icon: widget.icons ?? const SizedBox(),
        style: ButtonStyle(
            padding: MaterialStatePropertyAll(
                EdgeInsets.only(right: widget.paddingLeft ?? 0)),
            elevation: MaterialStatePropertyAll(10),
            fixedSize: MaterialStatePropertyAll(
                Size(widget.widthBox ?? 328, widget.heightBox ?? 62)),
            backgroundColor: MaterialStatePropertyAll(widget.color),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: widget.borderSide ?? BorderSide.none))),
      ),
    );
  }
}
