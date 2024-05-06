import 'package:template/pages/export.dart';

class WaitCheckoutView extends StatelessWidget {
  const WaitCheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> handleHome() async {
      Navigator.of(context).pushNamed(RouteName.home);
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 80.dp, horizontal: 24.dp),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green,
                child: IconButton(
                  icon: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 8.dp,
              ),
              Text('Thank you for placing the order',
                  style:
                      TextStyle(fontSize: 20.dp, fontWeight: FontWeight.w700)),
              SizedBox(
                height: 8.dp,
              ),
              Text('We’ll get to you as soon as possible',
                  style: TextStyle(fontSize: 17.dp, color: Colors.grey)),
              SizedBox(
                height: 110.dp,
              ),
              // SizedBox(
              //   height: 220,
              //   child: OverflowBox(
              //     minHeight: 270,
              //     maxHeight: 270,
              //     child: Lottie.network(
              //         'https://lottie.host/a171524f-978f-43d2-b4a6-62ffe31b9c37/0tKHq4B10A.json',
              //         repeat: false,
              //         height: 270,
              //         width: 270),
              //   ),
              // ),
              // Container(
              //   width: double.infinity,
              //   height:200,
              //   child: Lottie.network(
              //       'https://lottie.host/a171524f-978f-43d2-b4a6-62ffe31b9c37/0tKHq4B10A.json'),
              // ),
              Lottie.asset('assets/images/wait.json'),
              Spacer(),
              Button(
                label: 'Go Home',
                width: 328.dp,
                height: 62.dp,
                colorBackgroud: ColorsGlobal.globalPink,
                colorLabel: Colors.white,
                onPressed: () => handleHome(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
