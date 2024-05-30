import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

  const OtpView({Key? key, this.email, this.fromHomeScreen}) : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  late final OTPModel _otpModel;
  late final OTPViewModel _viewModel;
  ScaffoldMessengerState? _scaffoldMessenger;
  BuildContext? _previousContext;

  @override
  void initState() {
    super.initState();
    _viewModel = OTPViewModel();
    _otpModel = OTPModel(otpValues: List.filled(6, ''), email: widget.email!);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessenger ??= ScaffoldMessenger.of(context);
    _previousContext = context;
  }

  @override
  void dispose() {
    if (_previousContext != null) {
      _viewModel.disposeVerifyOTP();
    }
    super.dispose();
  }

  void _showErrorMessage(String message) {
    if (_scaffoldMessenger != null && mounted) {
      _scaffoldMessenger!.showSnackBar(SnackBar(content: Text(message)));
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
          color: ColorsGlobal.globalBlack,
        ),
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
              otpValues: _otpModel.otpValues,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 0, 10),
              child: GestureDetector(
                onTap: () {
                  if (_viewModel.canResend) {
                    _viewModel.resendOTP(_otpModel, context).catchError((error) {
                      if (error is AuthException && error.statusCode == 429) {
                        _showErrorMessage('Email rate limit exceeded, please wait a moment before retrying.');
                      } else {
                        _showErrorMessage('An error occurred, please try again.');
                      }
                    });
                    _viewModel.canResend = false;
                    _viewModel.startResendOTPTimer(context);
                  } else {
                    _showErrorMessage('OTP code is valid for 60 seconds, please wait');
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
                _viewModel.verifyOTP(context, _otpModel, fromHomeScreen: widget.fromHomeScreen!);
              },
              color: ColorsGlobal.globalPink,
              title: StringExtensions.confirm,
            ),
          ],
        ),
      ),
    );
  }
}
