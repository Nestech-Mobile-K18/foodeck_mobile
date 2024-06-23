import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/features/auth/bloc/authentication_bloc.dart';
import 'package:template/src/pages/export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Map<dynamic, dynamic> _userData = {};
  bool _isLogin = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loginWithGoogle() async {
    context.read<AuthenticationBloc>().add(AuthWithGoogleStarted());
  }

  Future<void> signInWithFacebook() async {
    // try {
    //   // Create an instance of FacebookLogin
    //   final result = await FacebookAuth.i
    //       .login(permissions: ['email', 'public_profile']).then((value) => {
    //             FacebookAuth.i
    //                 .getUserData(fields: "email, name")
    //                 .then((userData) async {
    //               setState(() {
    //                 // luu thong tin user FB login
    //                 _isLogin = true;
    //                 _userData = {...userData, 'provider': 'facebook'};
    //                 print('user login: $userData');
    //                 Navigator.of(context)
    //                     .pushNamed(RouteName.getCurrentLocation, arguments: _userData);
    //               });
    //             })
    //           });
    //           print('result $result');
    // } catch (e) {
    //   print(e);
    //   SnackBar(
    //     content: Text(e.toString()),
    //     backgroundColor: Theme.of(context).colorScheme.error,
    //   );
    // }

    context.read<AuthenticationBloc>().add(AuthWithFacebookStarted());
  }

  Future<void> signInWithEmail() async {
    GoRouter.of(context).push(RouteName.loginEmail);
  }

  Future<void> handleSignUp() async {
    GoRouter.of(context).push(RouteName.signup);
  }

  Future<void> signInWithApple() async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('The feature is being developed'),
        backgroundColor: ColorsGlobal.blue2));
  }

  Widget loginWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(
            AppPadding.p32, AppPadding.p48, AppPadding.p32, AppPadding.p32),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Button(
                  label: AppStrings.loginGoogle,
                  colorBackgroud: ColorsGlobal.red,
                  colorLabel: ColorsGlobal.white,
                  icon: MediaRes.icGoogle,
                  width: AppSize.s328,
                  height: AppSize.s62,
                  onPressed: () => loginWithGoogle()),
              Button(
                  label: AppStrings.loginFacebook,
                  colorBackgroud: ColorsGlobal.blue,
                  colorLabel: ColorsGlobal.white,
                  icon: MediaRes.icFacebook,
                  width: AppSize.s328,
                  height: AppSize.s62,
                  onPressed: () => signInWithFacebook()),
              Button(
                  label: AppStrings.loginApple,
                  colorBackgroud: ColorsGlobal.black,
                  colorLabel: ColorsGlobal.white,
                  icon: MediaRes.icApple,
                  width: AppSize.s328,
                  height: AppSize.s62,
                  onPressed: () => signInWithApple()),
              Button(
                  label: AppStrings.loginEmail,
                  colorLabel: ColorsGlobal.white,
                  colorBackgroud: ColorsGlobal.globalPink,
                  icon: MediaRes.icMail,
                  width: AppSize.s328,
                  height: AppSize.s62,
                  onPressed: () => signInWithEmail()),
              Button(
                  label: AppStrings.createAccount,
                  colorLabel: ColorsGlobal.grey,
                  colorBorder: ColorsGlobal.grey,
                  colorBackgroud: ColorsGlobal.white,
                  width: AppSize.s328,
                  height: AppSize.s62,
                  onPressed: () => handleSignUp()),
              Padding(
                padding: EdgeInsets.only(top: AppPadding.p32),
                child: Text(
                  AppStrings.bySigningUp,
                  style: AppTextStyle.decription,
                ),
              )
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const Image(
            image: AssetImage(MediaRes.imgLogin),
            fit: BoxFit.cover,
          ),
          backgroundColor: ColorsGlobal.transparent,
          toolbarHeight: AppSize.s295,
        ),
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationInProgress) {
              const CircularProgressIndicator();
            } else if (state is AuthenticationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Login success.'),
                  backgroundColor: ColorsGlobal.green));
              context.go(RouteName.getCurrentLocation);
            } else if (state is AuthenticationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login fail.')),
              );
            } else if (state is AuthenticationLogOut) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Log out success.'),
                    backgroundColor: ColorsGlobal.green),
              );
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return loginWidget();
            },
          ),
        ));
  }
}
