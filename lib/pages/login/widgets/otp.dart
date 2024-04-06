import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/main.dart';
import 'package:template/resources/colors.dart';
import 'package:template/resources/routes.dart';
import 'package:template/widgets/button.dart';

class Otp extends StatelessWidget {
  final String? email;

  const Otp({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _tokenController = TextEditingController();

    Future<void> handleVerifyOTP(String email, String token) async {
      try {
        final AuthResponse res = await supabase.auth
            .verifyOTP(type: OtpType.email, token: token, email: email);
        print(res);
        if (res != null) {
          const SnackBar(
            content: Text('Sign Up Success'),
            backgroundColor: Colors.green,
          );
           Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed(RouteName.login);
        // const SnackBar(
        }
      } on PostgrestException catch (error) {
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      } catch (error) {
        SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    }

    final defaultPinTheme = PinTheme(
      width: 76,
      height: 76,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'OTP',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(8),
            child: Divider(
              thickness: 8,
              height: 0,
              color: Colors.grey.shade100,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: const Text(
                  "Confirm the code we sent you",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,

                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.grey.shade600, width: 2),
                  ),
                ),
                controller: _tokenController,

                // onCompleted: onCompleted,
                // onSubmitted: (value) {
                //   print('object');
                //   print(value);
                // },
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(bottom: 100),
                child: const Text(
                  "Resend",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              Button(
                label: 'Create an account',
                width: 328,
                height: 62,
                colorBackgroud: ColorsGlobal.globalPink,
                colorLabel: Colors.white,
                onPressed: () => handleVerifyOTP(
                    email!.trim(), _tokenController.text.trim()),
              ),
            ],
          ),
        ));
  }
}
