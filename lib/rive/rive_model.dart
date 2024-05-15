import 'package:rive/rive.dart';

class RiveModel {
  final String action, src, artBoard, stateMachineName;
  late String? label = '';
  late SMITrigger? statusTrigger;
  late SMIBool? statusBool;

  RiveModel(
      {required this.action,
      this.label,
      required this.src,
      required this.artBoard,
      required this.stateMachineName,
      this.statusTrigger,
      this.statusBool});

  set setStatusTrigger(SMITrigger state) {
    statusTrigger = state;
  }

  set setStatusBool(SMIBool state) {
    statusBool = state;
  }
}

class RiveUtils {
  static SMITrigger getRiveTrigger(Artboard artBoard, String action,
      {required String stateMachineName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artBoard, stateMachineName);

    artBoard.addController(controller!);

    return controller.findSMI(action);
  }

  static SMIBool getRiveBool(Artboard artBoard, String action,
      {required String stateMachineName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artBoard, stateMachineName);

    artBoard.addController(controller!);

    return controller.findSMI(action);
  }

  static void changeSMITriggerState(SMITrigger input) {
    input.change(true);
  }

  static void changeSMIBoolState(SMIBool input) {
    input.change(input.value);
  }
}

// Light And Dark Animation
RiveModel lightOrDarkModel = RiveModel(
    action: 'IsPressed',
    src: 'assets/rives/switch_button_day&night.riv',
    artBoard: 'New Artboard',
    stateMachineName: 'State Machine 1');
// Pigeon Animation
RiveModel pigeonModel = RiveModel(
    action: 'hover',
    src: 'assets/rives/pigeons.riv',
    artBoard: 'New Artboard',
    stateMachineName: 'State Machine 1');
// Review Animation
RiveModel reviewModel = RiveModel(
    action: 'click',
    src: 'assets/rives/review_button.riv',
    artBoard: 'Publish Button',
    stateMachineName: 'State Machine 1');
// AddToCart Animation
RiveModel addToCartModel = RiveModel(
    action: 'add',
    src: 'assets/rives/add_to_cart.riv',
    artBoard: 'Added to Cart',
    stateMachineName: 'State Machine 1');
// Bottom Animation Icons
List<RiveModel> bottomModel = [
  RiveModel(
      src: 'assets/rives/animated_icon_set_-_1_color.riv',
      artBoard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      label: 'Explore',
      action: 'click'),
  RiveModel(
      src: 'assets/rives/heart.riv',
      artBoard: 'hert Effect',
      stateMachineName: 'switch',
      label: 'Saved',
      action: 'click'),
  // RiveModel(
  //     src: 'assets/rives/animated_icon_set_-_1_color.riv',
  //     artBoard: "LIKE/STAR",
  //     stateMachineName: "STAR_Interactivity",
  //     label: ''),
  RiveModel(
      src: 'assets/rives/animated_icon_set_-_1_color.riv',
      artBoard: "BELL",
      stateMachineName: "BELL_Interactivity",
      label: 'Notifications',
      action: 'click'),
  RiveModel(
      src: 'assets/rives/animated_icon_set_-_1_color.riv',
      artBoard: "USER",
      stateMachineName: "USER_Interactivity",
      label: 'Profile',
      action: 'click'),
];
