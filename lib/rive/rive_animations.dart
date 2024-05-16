import 'package:rive/rive.dart';
import 'package:template/source/export.dart';

class RiveAnimations {
  static Widget addToCartAnimation(VoidCallback onTap) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 70,
          width: 300,
          child: RiveAnimation.asset(
            alignment: Alignment.bottomCenter,
            fit: BoxFit.cover,
            RiveUtils.addToCartModel.src,
            artboard: RiveUtils.addToCartModel.artBoard,
            onInit: (artBoard) {
              RiveUtils.addToCartModel.statusTrigger = RiveUtils.getRiveTrigger(
                  artBoard, RiveUtils.addToCartModel.action,
                  stateMachineName: RiveUtils.addToCartModel.stateMachineName);
            },
          ),
        ),
      ),
    );
  }

  static Widget reviewAnimation(VoidCallback onTap) {
    return GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 100,
          child: RiveAnimation.asset(
            fit: BoxFit.cover,
            RiveUtils.reviewModel.src,
            artboard: RiveUtils.reviewModel.artBoard,
            onInit: (artBoard) {
              RiveUtils.reviewModel.statusTrigger = RiveUtils.getRiveTrigger(
                  artBoard, RiveUtils.reviewModel.action,
                  stateMachineName: RiveUtils.reviewModel.stateMachineName);
            },
          ),
        ));
  }

  static Widget pigeonAnimation() {
    return GestureDetector(
        onTap: () {
          RiveUtils.changeSMITriggerState(RiveUtils.pigeonModel.statusTrigger!);
        },
        child: RiveAnimation.asset(
          fit: BoxFit.cover,
          RiveUtils.pigeonModel.src,
          artboard: RiveUtils.pigeonModel.artBoard,
          onInit: (artBoard) {
            RiveUtils.pigeonModel.statusTrigger = RiveUtils.getRiveTrigger(
                artBoard, RiveUtils.pigeonModel.action,
                stateMachineName: RiveUtils.pigeonModel.stateMachineName);
          },
        ));
  }

  static Widget lightOrDarkAnimation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
              flex: 3, child: CustomText(content: 'Switch Light & Dark Mode')),
          Expanded(
            child: SizedBox(
              height: 30,
              child: GestureDetector(
                  onTap: () {
                    RiveUtils.changeSMIBoolState(
                        RiveUtils.lightOrDarkModel.statusBool!);
                    ThemeProvider.toggleTheme();
                  },
                  child: RiveAnimation.asset(
                    fit: BoxFit.cover,
                    RiveUtils.lightOrDarkModel.src,
                    artboard: RiveUtils.lightOrDarkModel.artBoard,
                    onInit: (artBoard) {
                      RiveUtils.lightOrDarkModel.statusBool =
                          RiveUtils.getRiveBool(
                              artBoard, RiveUtils.lightOrDarkModel.action,
                              stateMachineName:
                                  RiveUtils.lightOrDarkModel.stateMachineName);
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
