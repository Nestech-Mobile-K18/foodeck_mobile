import 'package:flutter/material.dart';
import 'package:template/pages/otp/models/otp_model.dart';
import 'package:template/pages/otp/vm/otp_view_model.dart';
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
    if (_viewModel.timer?.isActive == true) {
      _viewModel.timer?.cancel();
    }
    _otpModel = OTPModel(otpValues: otpValues, email: widget.email!);
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.timer?.isActive == true) {
      _viewModel.timer?.cancel();
    }
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
              padding: const EdgeInsets.fromLTRB(15, 20, 0, 10),
              child: GestureDetector(
                onTap: () {
                  if (_viewModel.canResend) {
                    // Use canResend variable from ViewModel
                    _viewModel.resendOTP(_otpModel, context);
                    _viewModel.canResend = false; // Reset the canResend variable
                    _viewModel.startResendOTPTimer(
                        context);// Restart the countdown
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('OTP code is valid for 60 seconds, please wait'),
                    ));
                  }
                },
                child: const CustomText(
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
