import 'package:template/pages/export.dart';
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
  late bool _obscureText;
  @override
  void initState() {
    _obscureText = widget.isPass;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      // onTap: _requestFocus,
      controller: widget.controller,
      obscureText: _obscureText ? true : false,

      onTap: widget.onTap,
      decoration: InputDecoration(
        labelText: widget.title,
        filled: true,
        labelStyle: TextStyle(
            color: widget.focusNode!.hasFocus
                ? ColorsGlobal.globalPink
                : ColorsGlobal.grey2),
        fillColor: ColorsGlobal.white,
        enabledBorder: CustomOutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r16),
          borderSide: const BorderSide(color: ColorsGlobal.grey3),
        ),
        focusedBorder: CustomOutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r16),
          borderSide: const BorderSide(
            color: ColorsGlobal.globalPink,
          ),
        ),
        suffixIcon: widget.isPass
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: ColorsGlobal.grey2,
                ),
              )
            : null,
      ),
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      style: const TextStyle(
        fontFamily: "Poppins",
      ),
    );
  }
}
