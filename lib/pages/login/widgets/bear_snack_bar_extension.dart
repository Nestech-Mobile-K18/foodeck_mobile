part of 'bear_snack_bar.dart';

class BearSnackBar extends StatefulWidget {
  const BearSnackBar({super.key, required this.content});

  final String content;

  @override
  State<BearSnackBar> createState() => _BearSnackBarState();
}

class _BearSnackBarState extends State<BearSnackBar> {
  late RiveAnimationController bear;

  @override
  void initState() {
    bear = SimpleAnimation('CLICK', autoplay: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 180,
          child: RiveAnimation.asset(
            'assets/rives/bearish_button.riv',
            controllers: [bear],
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
        Positioned(
            bottom: 25,
            child: CustomText(
              content: widget.content,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ))
      ],
    );
  }
}
