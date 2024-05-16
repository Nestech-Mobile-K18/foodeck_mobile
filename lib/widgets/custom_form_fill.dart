import 'package:template/source/export.dart';

class CustomFormFill extends StatefulWidget {
  const CustomFormFill(
      {super.key,
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
      this.padding,
      this.textInputFormatter,
      this.focusErrorBorderColor,
      this.exampleText,
      this.inputColor,
      this.boxShadow,
      this.heightBoxShadow,
      this.widthBoxShadow,
      this.hintColor,
      this.onTap});

  final TextInputType? textInputType;
  final Function(String)? function;
  final TextEditingController? textEditingController;
  final String? errorText;
  final String? hintText;
  final String? labelText;
  final Color? labelColor;
  final Color? borderColor;
  final Color? focusErrorBorderColor;
  final Widget? icons;
  final bool? obscureText;
  final BoxConstraints? boxSize;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? textInputFormatter;
  final EdgeInsets? padding;
  final String? exampleText;
  final Color? inputColor;
  final Color? boxShadow;
  final double? heightBoxShadow;
  final double? widthBoxShadow;
  final Color? hintColor;
  final VoidCallback? onTap;

  @override
  State<CustomFormFill> createState() => _CustomFormFillState();
}

class _CustomFormFillState extends State<CustomFormFill> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          width: widget.widthBoxShadow ?? 328,
          height: widget.heightBoxShadow ??
              MediaQuery.of(context).size.height * 0.0669,
          duration: const Duration(milliseconds: 1000),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: widget.boxShadow ?? Colors.transparent,
                    offset: const Offset(4, 4),
                    blurRadius: 5,
                    spreadRadius: 1)
              ]),
        ),
        TextFormField(
          onTap: widget.onTap,
          inputFormatters: widget.textInputFormatter,
          textAlign: widget.textAlign ?? TextAlign.start,
          obscureText: widget.obscureText ?? false,
          keyboardType: widget.textInputType,
          onChanged: widget.function,
          style: AppText.inter.copyWith(
              fontSize: 17, color: widget.inputColor ?? AppColor.globalPink),
          controller: widget.textEditingController,
          decoration: InputDecoration(
              suffixIcon: widget.icons,
              constraints:
                  widget.boxSize ?? const BoxConstraints(maxWidth: 328),
              labelText: widget.labelText,
              labelStyle:
                  AppText.inter.copyWith(fontSize: 12, color: Colors.grey),
              floatingLabelStyle: AppText.inter
                  .copyWith(fontSize: 12, color: widget.labelColor),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              errorText: widget.errorText,
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.red)),
              contentPadding: widget.padding ??
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: widget.borderColor ?? Colors.grey),
                  borderRadius: BorderRadius.circular(16)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          widget.focusErrorBorderColor ?? AppColor.globalPink),
                  borderRadius: BorderRadius.circular(16)),
              hintText: widget.hintText,
              hintStyle: AppText.inter.copyWith(
                  fontSize: 17,
                  color: widget.hintColor ?? AppColor.globalPinkShadow),
              helperText: widget.exampleText ?? '',
              helperStyle: const TextStyle(color: AppColor.buttonShadowBlack),
              errorStyle: const TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
