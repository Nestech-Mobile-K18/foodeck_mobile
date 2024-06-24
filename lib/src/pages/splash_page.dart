import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/features/auth/bloc/authentication_bloc.dart';
import 'package:template/src/features/network/bloc/network_bloc.dart';
import 'package:template/src/pages/export.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final AuthenticationBloc authBloc;
  late final NetworkBloc networkBloc;

  late StreamSubscription authStream;
  late StreamSubscription networkStream;
  bool isAuthenticationInitialized =
      false; // Add a flag to track authentication initialization

  @override
  void initState() {
    super.initState();
    networkBloc = context.read<NetworkBloc>()..add(NetworkObserve());
    authBloc = context.read<AuthenticationBloc>()
      ..add(AppStarted()); // Initialize authBloc

    networkStream = networkBloc.stream.listen((state) {
      if (!mounted) return; // Check if the widget is still mounted

      if (state is NetworkSuccess) {
        authBloc.add(AppStarted());
      } else if (state is NetworkFailure) {
        GoRouter.of(context).push(RouteName.noInternet);
      }
    });

    authStream = authBloc.stream.listen((state) {
      if (!mounted) return; // Check if the widget is still mounted

      if (state is AuthenticationSuccess) {
        GoRouter.of(context).push(RouteName.getCurrentLocation);
      } else if (state is AuthenticationFailure) {
        GoRouter.of(context).push(RouteName.login);
      }
    });
  }

  @override
  void dispose() {
    authStream.cancel(); // Cancel the stream subscription
    networkStream.cancel();
    authBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      splashScreenBody: Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(MediaRes.backgroundSplash),
                fit: BoxFit.fill,
              ),
              border: Border.all(width: 0, color: ColorsGlobal.transparent),
            ),
            child: const Center(
              child: Image(
                image: AssetImage(MediaRes.logoSplash),
                fit: BoxFit.contain,
              ),
            )),
      ),
    );
  }
}
