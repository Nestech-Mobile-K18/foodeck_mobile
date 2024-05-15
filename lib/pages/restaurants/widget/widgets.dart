import 'package:rive/rive.dart';
import 'package:template/source/export.dart';

class CustomWidget {
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
            addToCartModel.src,
            artboard: addToCartModel.artBoard,
            onInit: (artBoard) {
              addToCartModel.statusTrigger = RiveUtils.getRiveTrigger(
                  artBoard, addToCartModel.action,
                  stateMachineName: addToCartModel.stateMachineName);
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
            reviewModel.src,
            artboard: reviewModel.artBoard,
            onInit: (artBoard) {
              reviewModel.statusTrigger = RiveUtils.getRiveTrigger(
                  artBoard, reviewModel.action,
                  stateMachineName: reviewModel.stateMachineName);
            },
          ),
        ));
  }

  static Widget pigeonAnimation() {
    return GestureDetector(
        onTap: () {
          RiveUtils.changeSMITriggerState(pigeonModel.statusTrigger!);
        },
        child: RiveAnimation.asset(
          fit: BoxFit.cover,
          pigeonModel.src,
          artboard: pigeonModel.artBoard,
          onInit: (artBoard) {
            pigeonModel.statusTrigger = RiveUtils.getRiveTrigger(
                artBoard, pigeonModel.action,
                stateMachineName: pigeonModel.stateMachineName);
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
                    RiveUtils.changeSMIBoolState(lightOrDarkModel.statusBool!);
                    context.read<ThemeProvider>().toggleTheme();
                  },
                  child: RiveAnimation.asset(
                    fit: BoxFit.cover,
                    lightOrDarkModel.src,
                    artboard: lightOrDarkModel.artBoard,
                    onInit: (artBoard) {
                      lightOrDarkModel.statusBool = RiveUtils.getRiveBool(
                          artBoard, lightOrDarkModel.action,
                          stateMachineName: lightOrDarkModel.stateMachineName);
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
