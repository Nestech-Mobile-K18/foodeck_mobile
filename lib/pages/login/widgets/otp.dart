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
          backgroundColor: ColorsGlobal.green,
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
      width: AppSize.s76,
      height: AppSize.s76,
      textStyle: TextStyle(
        fontSize: AppSize.s22,
        color: ColorsGlobal.black,
      ),
      decoration: BoxDecoration(
        color: ColorsGlobal.white,
        borderRadius: BorderRadius.circular(AppSize.s10),
        border: Border.all(color: ColorsGlobal.grey3),
      ),
    );
    return Scaffold(
        appBar: const AppBarScreen(
            title: AppStrings.otp, ),
        body: Padding(
          padding: EdgeInsets.all(AppPadding.p24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: AppMargin.m24),
                child: Text(
                  AppStrings.confirmCode,
                  style: AppTextStyle.title,
                ),
              ),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border:
                        Border.all(color: ColorsGlobal.grey, width: AppSize.s2),
                  ),
                ),
                controller: _tokenController,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: AppMargin.m100),
                child: Text(AppStrings.resend, style: AppTextStyle.decription),
              ),
              Button(
                label: AppStrings.createAccount,
                width: AppSize.s328,
                height: AppSize.s62,
                colorBackgroud: ColorsGlobal.globalPink,
                colorLabel: ColorsGlobal.white,
                onPressed: () => handleVerifyOTP(
                    email!.trim(), _tokenController.text.trim()),
              ),
            ],
          ),
        ));
  }
}
