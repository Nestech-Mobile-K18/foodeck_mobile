import 'package:template/pages/export.dart';

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
        const SnackBar(
          content: Text('Sign Up Success'),
          backgroundColor: Colors.green,
        );
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed(RouteName.login);
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
      width: 76.dp,
      height: 76.dp,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.dp),
        border: Border.all(color: Colors.grey.shade200),
      ),
    );
    return Scaffold(
        appBar: const AppBarScreen(title: 'OTP',),
        
        body: Padding(
          padding: EdgeInsets.all(24.dp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 24.dp),
                child: Text(
                  "Confirm the code we sent you",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.dp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border:
                        Border.all(color: Colors.grey.shade600, width: 2.dp),
                  ),
                ),
                controller: _tokenController,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 100.dp),
                child: Text(
                  "Resend",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.dp,
                  ),
                ),
              ),
              Button(
                label: 'Create an account',
                width: 328.dp,
                height: 62.dp,
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
