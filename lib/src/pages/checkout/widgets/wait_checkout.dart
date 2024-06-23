import 'package:template/src/pages/export.dart';

class WaitCheckout extends StatelessWidget {
  const WaitCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> handleHome() async {
      Navigator.of(context).pushNamed(RouteName.home);
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppPadding.p80, horizontal: AppPadding.p24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: ColorsGlobal.green,
                child: IconButton(
                  icon: const Icon(
                    Icons.check,
                    color: ColorsGlobal.white,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: AppSize.s8,
              ),
              Text(AppStrings.thankYou,
                  style: AppTextStyle.title),
              SizedBox(
                height: AppSize.s8,
              ),
              Text(AppStrings.weWillGetToYou,
                  style: AppTextStyle.decription),
              SizedBox(
                height: AppSize.s12,
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
              Lottie.asset('assets/lottie/wait.json'),
              const Spacer(),
              Button(
                label: AppStrings.goHome,
                width: AppSize.s328,
                height: AppSize.s62,
                colorBackgroud: ColorsGlobal.globalPink,
                colorLabel: ColorsGlobal.white,
                onPressed: () => handleHome(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
