import 'package:template/source/export.dart';

class Otp extends StatefulWidget {
  const Otp({super.key, required this.email});

  final String email;

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  void initState() {
    ShowBearSnackBar.showBearSnackBar(context, 'OTP in your email');
    super.initState();
  }

  final currentIndex = ValueNotifier(0);

  List<String> otpValues = List.filled(6, '');

  Future checkOTP() async {
    String token = otpValues.join();
    try {
      await supabase.auth
          .verifyOTP(token: token, type: OtpType.email, email: widget.email);
    } on AuthException catch (error) {
      ShowBearSnackBar.showBearSnackBar(context, error.message);
    } catch (error) {
      ShowBearSnackBar.showBearSnackBar(context, 'Error!, please retry');
    }
  }

  Future resendOTP() async {
    try {
      await supabase.auth
          .signInWithOtp(shouldCreateUser: false, email: widget.email)
          .then((value) =>
              ShowBearSnackBar.showBearSnackBar(context, 'OTP in your email'));
    } on AuthException catch (error) {
      ShowBearSnackBar.showBearSnackBar(context, error.message);
    } catch (error) {
      ShowBearSnackBar.showBearSnackBar(context, 'Error!, please retry');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          unFocus;
        },
        child: Scaffold(
            appBar: AppBar(
                shape: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 8, color: dividerGrey)),
                title: const CustomText(
                    content: 'OTP', fontWeight: FontWeight.bold)),
            body: SingleChildScrollView(
                child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            content:
                                'Confirm the code we sent to ${widget.email}',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
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
                                    boxShadow: currentIndex.value >= index
                                        ? Colors.pink.shade100
                                        : Colors.white,
                                    heightBoxShadow: 48,
                                    widthBoxShadow: 50,
                                    padding: EdgeInsets.zero,
                                    textAlign: TextAlign.center,
                                    boxSize: const BoxConstraints(
                                        maxWidth: 50, maxHeight: 76),
                                    textInputType: TextInputType.number,
                                    borderColor: currentIndex.value >= index
                                        ? globalPink
                                        : Colors.grey,
                                    textInputFormatter: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(1)
                                    ],
                                    function: (value) {
                                      otpValues[index] = value;
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
                                child: const CustomText(
                                    content: 'Resend',
                                    fontSize: 13,
                                    textDecoration: TextDecoration.underline))),
                        ValueListenableBuilder(
                          valueListenable: currentIndex,
                          builder:
                              (BuildContext context, int value, Widget? child) {
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
                                          ? globalPink
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
                                                  offset: const Offset(-4, -4),
                                                  blurRadius: 15,
                                                  spreadRadius: 1)
                                            ]
                                          : null),
                                  duration: const Duration(seconds: 1),
                                  child: Center(
                                    child: AnimatedDefaultTextStyle(
                                      style: AppText.inter.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      duration: const Duration(seconds: 1),
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
                      ])),
            ))));
  }
}
