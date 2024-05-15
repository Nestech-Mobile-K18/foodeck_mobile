part of 'splash_page.dart';

class SplashPageAnimation extends StatelessWidget {
  const SplashPageAnimation({
    super.key,
    required this.animationFirstAndLast,
    required this.animation3,
    required this.animation2,
  });

  final bool animationFirstAndLast;
  final bool animation3;
  final bool animation2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 1500),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: animationFirstAndLast
                    ? null
                    : const DecorationImage(
                        image: AssetImage(Assets.splashScreen),
                        fit: BoxFit.cover)),
          ),
          Positioned(
            top: 168.33,
            child: AnimatedScale(
                scale: animationFirstAndLast ? 0 : 1,
                duration: const Duration(milliseconds: 1500),
                child: AnimatedOpacity(
                    opacity: animationFirstAndLast ? 0 : 1,
                    duration: const Duration(milliseconds: 1500),
                    child: AnimatedRotation(
                        turns: animationFirstAndLast ? 0 : 1,
                        duration: const Duration(milliseconds: 1500),
                        child: Image.asset(Assets.foodDeck)))),
          ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 1500),
              top: 290,
              left: animationFirstAndLast ? 0 : 92,
              child: AnimatedOpacity(
                  opacity: animationFirstAndLast ? 0 : 1,
                  duration: const Duration(milliseconds: 1500),
                  child: const CustomText(
                      content: 'Foodeck',
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 1500),
              top: animationFirstAndLast ? 800 : 387,
              child: AnimatedOpacity(
                  opacity: animationFirstAndLast ? 0 : 1,
                  duration: const Duration(milliseconds: 1500),
                  child: const CustomText(
                      content:
                          'Aliquam commodo tortor lacinia lorem\naccumsan aliquam',
                      textAlign: TextAlign.center,
                      color: Colors.white))),
          Positioned(
              top: animation3 ? 450 : 500,
              child: animation3
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: animationFirstAndLast
                          ? null
                          : Lottie.asset(Assets.done))
                  : AnimatedOpacity(
                      opacity: animation2 ? 0 : 1,
                      duration: const Duration(milliseconds: 1500),
                      child: const WaveDots(size: 36, color: Colors.white))),
          animationFirstAndLast
              ? const LoadingAnimationRive(color: Colors.transparent)
              : const SizedBox()
        ],
      ),
    );
  }
}
