import 'package:template/source/export.dart';

part 'splash_page_extension_ui.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    context.read<SplashPageBloc>().add(SplashPageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashPageBloc, SplashPageState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case SplashPageInitial:
            return const SplashPageAnimation(
                animationFirstAndLast: true,
                animation3: false,
                animation2: true);
          case SplashLoadingAnimationState:
            return const SplashPageAnimation(
                animationFirstAndLast: false,
                animation3: false,
                animation2: true);
          case SplashLoadingAnimationSecondState:
            return const SplashPageAnimation(
                animationFirstAndLast: false,
                animation3: false,
                animation2: false);
          case SplashLoadingAnimationThirdState:
            return const SplashPageAnimation(
                animationFirstAndLast: false,
                animation3: true,
                animation2: false);
          case SplashLoadingAnimationFourthState:
            return const SplashPageAnimation(
                animationFirstAndLast: true,
                animation3: true,
                animation2: false);
          default:
            return const SizedBox();
        }
      },
    );
  }
}
