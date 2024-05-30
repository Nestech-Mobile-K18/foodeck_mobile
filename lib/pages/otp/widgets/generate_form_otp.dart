import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/resources/colors.dart';

class FormOTP extends StatefulWidget {
  final List<String>? otpValues;
  final int? countForm;
  const FormOTP({super.key, this.otpValues, this.countForm});

  @override
  _FormOTPState createState() => _FormOTPState();
}

class _FormOTPState extends State<FormOTP> {
  List<bool> isFilled = [];

  @override
  void initState() {
    super.initState();
    isFilled = List<bool>.filled(widget.countForm ?? 1, false);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isFilled = [];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.countForm ?? 1,
          (index) => Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: ColorsGlobal.globalWhite,
                border: Border.all(color: Color.fromRGBO(217, 217, 217, 1)),
                borderRadius: BorderRadius.circular(16)),
            child: TextField(
              onChanged: (value) {
                widget.otpValues?[index] = value;
                setState(() {
                  isFilled[index] = value.isNotEmpty;
                });
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty && index > 0 && isFilled[index - 1]) {
                  // Nếu giá trị rỗng và ô trước đó đã có dữ liệu, di chuyển focus tới ô trước đó
                  FocusScope.of(context).previousFocus();
                }
              },
              decoration: InputDecoration(border: InputBorder.none),
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
        ),
      ),
    );
  }
}
