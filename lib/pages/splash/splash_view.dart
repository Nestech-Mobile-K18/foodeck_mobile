import 'package:template/pages/export.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      duration: const Duration(milliseconds: 2000),
      nextScreen: const LoginView(),
      splashScreenBody: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage(MediaRes.backgroundSplash),
              fit: BoxFit.fill,
            ),
            border: Border.all(width: 0, color: Colors.transparent),
          ),
          child: const Center(
            child: Image(
              image: AssetImage(MediaRes.logoSplash),
              fit: BoxFit.contain,
            ),
          ) /* add child content here */,
        ),
      ),
    );
  }
}
