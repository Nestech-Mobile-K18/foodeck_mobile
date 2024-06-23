import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/features/signup/bloc/signup_bloc.dart';
import 'package:template/src/pages/export.dart';

class Otp extends StatelessWidget {
  final String? email;

  const Otp({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _tokenController = TextEditingController();

    Future<void> handleVerifyOTP(String email, String token) async {
    context.read<SignupBloc>().add(VerifyStarted(email: email,token: token));

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

    Widget opt(){
      return Padding(
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
        );
    }
    return Scaffold(
        appBar: const AppBarScreen(
          title: AppStrings.otp,
          isLeading: false,
        ),
        body: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is VerifyInProgress) {
              const CircularProgressIndicator();
            } else if (state is SignupSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Sign up success. Go back Login page to login with Email'),
                  backgroundColor: ColorsGlobal.green));
              context.go(RouteName.login);
            } else if (state is SignupFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sign up fail.')),
              );
            } 
          },
          child: BlocBuilder<SignupBloc, SignupState>(
            builder: (context, state) {
              return opt();
            },
          ),
        ));
  }
}
