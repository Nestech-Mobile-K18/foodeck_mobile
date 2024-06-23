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

    initializeNetworkBloc().then((networkState) {
      if (networkState is NetworkFailure) {
        // no internet
        GoRouter.of(context).push(RouteName.noInternet);
      } else if (networkState is NetworkSuccess &&
          !isAuthenticationInitialized) {
        isAuthenticationInitialized = true; // Set the flag to true

        initializeAuthenticationBloc().then((authState) {
          if (authState is AuthenticationFailure) {
            // login not yet
            GoRouter.of(context).push(RouteName.login);
          } else if (authState is AuthenticationSuccess) {
            if (mounted) {
              //find current location
              GoRouter.of(context).push(RouteName.getCurrentLocation);
            }
          }
        });
      }
    });
  }

  Future<NetworkState> initializeNetworkBloc() async {
    final completer =
        Completer<NetworkState>(); // Completer to handle the initialization

    networkBloc = context.read<NetworkBloc>()..add(NetworkObserve());
    networkStream = networkBloc.stream.listen((state) {
      if (!mounted) return; // Check if the widget is still mounted

      if (state is NetworkSuccess) {
        completer.complete(
            NetworkSuccess()); // Complete the completer with NetworkSuccess
      } else if (state is NetworkFailure) {
        completer.complete(
            NetworkFailure()); // Complete the completer with NetworkFailure
      }
    });

    return completer.future;
  }

  Future<AuthenticationState> initializeAuthenticationBloc() async {
    final completer = Completer<
        AuthenticationState>(); // Completer to handle the initialization

    authBloc = context.read<AuthenticationBloc>()..add(AppStarted());
    authStream = authBloc.stream.listen((state) {
      print('sstate $state');

      if (!mounted) return; // Check if the widget is still mounted

      if (state is AuthenticationSuccess) {

  
        completer.complete(AuthenticationSuccess(userInfor: state.userInfor
            // userId: state.userId,
            // name: state.name,
            // avatar: state.avatar,
            // password: state.password,
            // phone: state.password,
            // typeAuthen: state
            //     .typeAuthen
                )); // Complete the completer with NetworkSuccess
      } else if (state is AuthenticationFailure) {
        completer.complete(
            AuthenticationFailure()); // Complete the completer with NetworkFailure
      }
    });
    return completer.future;
  }

  @override
  void dispose() {
    authStream.cancel(); // Cancel the stream subscription
    networkStream.cancel();
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
