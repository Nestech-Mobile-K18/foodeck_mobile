import 'package:template/source/export.dart';

class CustomFormFill extends StatelessWidget {
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
      this.onTap,
      this.onEditingComplete,
      this.prefixIcons});

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
  final Widget? prefixIcons;
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
  final VoidCallback? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          width: widthBoxShadow ?? 328,
          height:
              heightBoxShadow ?? MediaQuery.of(context).size.height * 0.0669,
          duration: const Duration(milliseconds: 1000),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: boxShadow ?? Colors.transparent,
                    offset: const Offset(4, 4),
                    blurRadius: 5,
                    spreadRadius: 1)
              ]),
        ),
        TextFormField(
          onEditingComplete: onEditingComplete,
          onTap: onTap,
          inputFormatters: textInputFormatter,
          textAlign: textAlign ?? TextAlign.start,
          obscureText: obscureText ?? false,
          keyboardType: textInputType,
          onChanged: function,
          style: AppText.inter
              .copyWith(fontSize: 17, color: inputColor ?? AppColor.globalPink),
          controller: textEditingController,
          decoration: InputDecoration(
              prefixIcon: prefixIcons,
              suffixIcon: icons,
              constraints: boxSize ?? const BoxConstraints(maxWidth: 328),
              labelText: labelText,
              labelStyle:
                  AppText.inter.copyWith(fontSize: 12, color: Colors.grey),
              floatingLabelStyle:
                  AppText.inter.copyWith(fontSize: 12, color: labelColor),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              errorText: errorText,
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.red)),
              contentPadding: padding ??
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor ?? Colors.grey),
                  borderRadius: BorderRadius.circular(16)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: focusErrorBorderColor ?? AppColor.globalPink),
                  borderRadius: BorderRadius.circular(16)),
              hintText: hintText,
              hintStyle: AppText.inter.copyWith(
                  fontSize: 17, color: hintColor ?? AppColor.globalPinkShadow),
              helperText: exampleText ?? '',
              helperStyle: const TextStyle(color: AppColor.buttonShadowBlack),
              errorStyle: const TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
