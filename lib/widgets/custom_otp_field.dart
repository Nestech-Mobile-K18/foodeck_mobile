import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPField extends StatefulWidget {
  final bool first;
  final bool last;
  final TextEditingController otpController;
  const OTPField({
    super.key,
    required this.first,
    required this.last,
    required this.otpController,
  });

  @override
  State<OTPField> createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  //

  void _onchangeOTP(value) {
    setState(() {
      if (value.toString().length == 1 && widget.last == false) {
        FocusScope.of(context).nextFocus();
      }
      if (value.toString().isEmpty && widget.first == false) {
        FocusScope.of(context).previousFocus();
      }
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 76,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: widget.otpController,
        onChanged: _onchangeOTP,
        onSaved: (newvalue) {},
        showCursor: false,
        readOnly: false,
        autofocus: false,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        style: GoogleFonts.inter(
          fontSize: 36,
          fontWeight: FontWeight.w500,
          color: AppColor.primary,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 1,
              color: widget.otpController.value.text.isNotEmpty
                  ? AppColor.primary
                  : AppColor.grey4,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 1,
              color: AppColor.primary,
            ),
          ),
        ),
      ),
    );
  }
}
