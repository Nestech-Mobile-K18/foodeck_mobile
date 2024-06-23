import 'package:device_preview/device_preview.dart';
import 'package:template/src/pages/export.dart';
import 'package:template/src/resources/fonts.dart';
import 'package:template/src/config/routers/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    // DeviceOrientation.portraitUp,
    //     // DeviceOrientation.portraitDown,
    //   ]);
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        // return MaterialApp(
        //   locale: DevicePreview.locale(context),
        //   // không cho thay đổi size chữ khi thiết bị thay đổi
        //   builder: (BuildContext context, Widget? child) {
        //     return MediaQuery(
        //       data: MediaQuery.of(context).copyWith(
        //         textScaleFactor: 1.0,
        //       ),
        //       child: child!,
        //     );
        //   },
        //   // builder: DevicePreview.appBuilder,
        //   // theme: ThemeData.light(),
        //   // darkTheme: ThemeData.dark(),
        //   debugShowCheckedModeBanner: false,
        //   title: AppStrings.titleApp,
        //   theme: ThemeData(
        //     useMaterial3: true,
        //     visualDensity: VisualDensity.adaptivePlatformDensity,
        //     fontFamily: Fonts.inter,
        //     appBarTheme: const AppBarTheme(color: ColorsGlobal.transparent),
        //   ),
        //   onGenerateRoute: generateRoute,
        //   initialRoute: RouteName.splash,
        // );

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}
