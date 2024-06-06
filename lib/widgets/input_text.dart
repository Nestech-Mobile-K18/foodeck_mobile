import 'package:flutter/material.dart';
import 'package:template/resources/colors.dart';
import 'package:template/widgets/custom_outline_input_border.dart';

// class InputText extends StatelessWidget {
//   const InputText({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//   }
// }
class InputText extends StatefulWidget {
  const InputText(
      {Key? key,
      this.controller,
      this.isPass = false,
      this.validator,
      this.onChanged,
      this.onSave,
      this.hintText,
      this.keyboardType,
      required this.title,
      this.focusNode,
      this.onTap})
      : super(key: key);
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onSave;
  final String? hintText;
  final TextInputType? keyboardType;
  final String title;
  final bool isPass;
  final FocusNode? focusNode;
  final Function()? onTap;

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      // onTap: _requestFocus,
      controller: widget.controller,
      obscureText: widget.isPass ? true : false,
      onTap: widget.onTap,
      decoration: InputDecoration(
        labelText: widget.title,
        filled: true,
        labelStyle: TextStyle(
            color: widget.focusNode!.hasFocus
                ? ColorsGlobal.globalPink
                : Colors.grey.shade500),
        fillColor: Colors.white,
        enabledBorder: CustomOutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: CustomOutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: ColorsGlobal.globalPink,
          ),
        ),
      ),
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      style: const TextStyle(
        fontFamily: "Poppins",
      ),
    );
  }
}
