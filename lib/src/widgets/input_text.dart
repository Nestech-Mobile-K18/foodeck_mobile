import 'package:template/src/pages/export.dart';
import 'package:template/src/widgets/custom_outline_input_border.dart';

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
      this.onTap,
      this.initValue, this.isReadOnly=false})
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
  final String? initValue;
  final bool isReadOnly;

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late bool _obscureText;
  late String? _errorText;

  @override
  void initState() {
    _obscureText = widget.isPass;

    super.initState();
  }

  void _clearError() {
    setState(() {
      _errorText = null; // Clear the error message
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: widget.focusNode,
      // onTap: _requestFocus,
      controller: widget.controller,
      obscureText: _obscureText ? true : false,
      initialValue: widget.initValue,
      onTap: widget.onTap,
      readOnly: widget.isReadOnly,
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
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: ColorsGlobal.grey2,
                ),
              )
            : null,
      ),
      validator: (value) {
        if (widget.validator != null) {
          _errorText = widget.validator!(value);
        }
        return _errorText;
      }, // Return the custom error message,
      onChanged: (value) {
        print('change..........');
        _clearError(); // Clear the error when the user starts typing
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      keyboardType: widget.keyboardType,
      style: const TextStyle(
        fontFamily: "Poppins",
      ),
    );
  }
}
