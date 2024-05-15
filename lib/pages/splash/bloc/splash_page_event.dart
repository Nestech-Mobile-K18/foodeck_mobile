part of 'splash_page_bloc.dart';

@immutable
sealed class SplashPageEvent extends Equatable {
  const SplashPageEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SplashPageInitialEvent extends SplashPageEvent {}
