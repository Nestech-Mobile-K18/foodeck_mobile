part of 'splash_page_bloc.dart';

@immutable
sealed class SplashPageState extends Equatable {
  const SplashPageState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SplashPageInitial extends SplashPageState {}

class SplashLoadingAnimationState extends SplashPageState {}

class SplashLoadingAnimationSecondState extends SplashPageState {}

class SplashLoadingAnimationThirdState extends SplashPageState {}

class SplashLoadingAnimationFourthState extends SplashPageState {}

class SplashLoadedAnimationSuccessState extends SplashPageState {}
