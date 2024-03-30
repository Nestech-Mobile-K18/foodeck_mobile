import 'package:flutter/material.dart';
import 'package:template/pages/otp/otp_model.dart';
import 'package:template/pages/otp/otp_view_model.dart';
import 'package:template/pages/otp/widgets/generate_form_otp.dart';

import 'package:template/widgets/cross_bar.dart';
import 'package:template/widgets/custom_text.dart';
import 'package:template/widgets/method_button.dart';
import 'package:template/resources/const.dart';

class OtpView extends StatefulWidget {
  final String? email;
  final bool? fromHomeScreen;
  const OtpView({super.key, this.email, this.fromHomeScreen});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final OTPViewModel _viewModel = OTPViewModel();
  List<String> otpValues = List.filled(6, '');
  late final OTPModel _otpModel;

  @override
  void initState() {
    super.initState();
    _otpModel = OTPModel(otpValues: otpValues, email: widget.email!);
  }

  @override
  void dispose() {
    if (_viewModel.timer.isActive) {
      _viewModel.timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const CustomText(
            title: StringExtensions.otp,
            size: 17,
            fontWeight: FontWeight.w600,
            color: ColorsGlobal.globalBlack),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CrossBar(height: 10),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 20, 0, 10),
              child: const CustomText(
                title: StringExtensions.titleConfirmOTP,
                color: ColorsGlobal.globalBlack,
                fontWeight: FontWeight.w600,
                size: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FormOTP(
              countForm: 6,
              otpValues: otpValues,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 0, 10),
              child: GestureDetector(
                onTap: () {
                  if (_viewModel.canResend) {
                    // Sử dụng biến canResend từ ViewModel
                    _viewModel.resendOTP(_otpModel, context);
                    _viewModel.canResend = false; // Đặt lại biến canResend
                    _viewModel.startResendOTPTimer(
                        context); // Khởi động lại đếm ngược
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Mã OTP có hiệu lực trong 60s vui lòng đợi'),
                    ));
                  }
                },
                child: CustomText(
                  title: StringExtensions.resend,
                  size: 13,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MethodButton(
                onTap: () {
                  _viewModel.verifyOTP(context, _otpModel,
                      fromHomeScreen: widget.fromHomeScreen!);
                },
                color: ColorsGlobal.globalPink,
                title: StringExtensions.confirm)
          ],
        ),
      ),
    );
  }
}
