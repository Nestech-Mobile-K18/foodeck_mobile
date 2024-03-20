import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/main.dart';
import 'package:template/pages/login/widgets/create_account.dart';
import 'package:template/pages/login/widgets/login_email.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/text_styles.dart';
import 'package:template/widgets/form_fill.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final currentIndex = ValueNotifier(0);
  final otpController = TextEditingController();
  Future checkOTP() async {
    await supabase.auth
        .verifyOTP(token: otpController.text, type: OtpType.email);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  Get.to((const CreateAccount()),
                      transition: Transition.leftToRightWithFade);
                },
              ),
              shape: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 8, color: primaryGrey)),
              title: Text('OTP',
                  style: inter.copyWith(
                      fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Confirm the code we sent you',
                              style: inter.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: ValueListenableBuilder(
                              valueListenable: currentIndex,
                              builder: (BuildContext context, int value,
                                  Widget? child) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    4,
                                    (index) => CustomFormFill(
                                      textEditingController: otpController,
                                      textAlign: TextAlign.center,
                                      boxWidth: 76,
                                      boxHeight: 76,
                                      textInputType: TextInputType.number,
                                      borderColor: currentIndex.value >= index
                                          ? lightPink
                                          : Colors.grey,
                                      filteringTextInputFormatter:
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                      lengthLimitingTextInputFormatter:
                                          LengthLimitingTextInputFormatter(1),
                                      function: (value) {
                                        setState(() {
                                          currentIndex.value = index;
                                        });
                                        if (value.length == 1) {
                                          currentIndex.value == 3
                                              ? null
                                              : FocusScope.of(context)
                                                  .nextFocus();
                                        } else {
                                          currentIndex.value == 0
                                              ? null
                                              : FocusScope.of(context)
                                                  .previousFocus();
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Text(
                              'Resend',
                              style: inter.copyWith(
                                  fontSize: 13, color: Colors.grey),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: currentIndex,
                            builder: (BuildContext context, int value,
                                Widget? child) {
                              return GestureDetector(
                                onTap: () {
                                  currentIndex.value == 3
                                      ? Get.to(() => const LoginEmail())
                                      : null;
                                },
                                child: Center(
                                  child: AnimatedContainer(
                                    height: 62,
                                    width: 328,
                                    decoration: BoxDecoration(
                                        color: currentIndex.value == 3
                                            ? lightPink
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: currentIndex.value == 3
                                            ? [
                                                BoxShadow(
                                                    color: Colors.grey.shade500,
                                                    offset: const Offset(4, 4),
                                                    blurRadius: 15,
                                                    spreadRadius: 1),
                                                BoxShadow(
                                                    color: Colors.grey.shade200,
                                                    offset:
                                                        const Offset(-4, -4),
                                                    blurRadius: 15,
                                                    spreadRadius: 1)
                                              ]
                                            : null),
                                    duration: const Duration(seconds: 2),
                                    child: Center(
                                      child: AnimatedDefaultTextStyle(
                                        style: inter.copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        duration: const Duration(seconds: 2),
                                        child: Text(currentIndex.value == 3
                                            ? 'Confirm'
                                            : ''),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ])))));
  }
}
