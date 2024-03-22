import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/login/widgets/login_email.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';
import 'package:template/widgets/form_fill.dart';

class Otp extends StatefulWidget {
  const Otp({super.key, required this.email});
  final String email;
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final currentIndex = ValueNotifier(0);
  final supabase = Supabase.instance.client;

  Future checkOTP() async {
    try {
      await supabase.auth
          .verifyOTP(
              token: otpFill.elementAt(0).toString() +
                  otpFill.elementAt(1).toString() +
                  otpFill.elementAt(2).toString() +
                  otpFill.elementAt(3).toString() +
                  otpFill.elementAt(4).toString() +
                  otpFill.elementAt(5).toString(),
              type: OtpType.email,
              email: widget.email)
          .then((value) => Get.to(() => const LoginEmail()));
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error occurred, please retry')));
    }
  }

  Future resendOTP() async {
    try {
      await supabase.auth.resend(type: OtpType.email, email: widget.email);
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error occurred, please retry')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
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
                                    6,
                                    (index) => CustomFormFill(
                                      padding: EdgeInsets.zero,
                                      textEditingController:
                                          otpFill[index].otpSlot,
                                      textAlign: TextAlign.center,
                                      boxWidth: 50,
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
                                          currentIndex.value == 5
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
                            child: GestureDetector(
                              onTap: () {
                                resendOTP();
                              },
                              child: Text(
                                'Resend',
                                style: inter.copyWith(
                                    fontSize: 13, color: Colors.grey),
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: currentIndex,
                            builder: (BuildContext context, int value,
                                Widget? child) {
                              return GestureDetector(
                                onTap: () {
                                  currentIndex.value == 5 ? checkOTP() : null;
                                },
                                child: Center(
                                  child: AnimatedContainer(
                                    height: 62,
                                    width: 328,
                                    decoration: BoxDecoration(
                                        color: currentIndex.value == 5
                                            ? lightPink
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: currentIndex.value == 5
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
                                        child: Text(currentIndex.value == 5
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
