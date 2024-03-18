import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      this.icons,
      required this.text,
      required this.color,
      this.borderSide});
  final VoidCallback onPressed;
  final Widget? icons;
  final Text text;
  final Color color;
  final BorderSide? borderSide;
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
        icon: widget.icons ?? const Text(''),
        style: ButtonStyle(
            fixedSize: const MaterialStatePropertyAll(Size.fromHeight(62)),
            backgroundColor: MaterialStatePropertyAll(widget.color),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: widget.borderSide ?? BorderSide.none))),
      ),
    );
  }
}
