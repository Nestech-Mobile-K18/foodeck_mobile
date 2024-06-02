part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState extends Equatable {
  const HomePageState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class HomePageInitial extends HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageSelectIndex0State extends HomePageState {
  final int index;

  const HomePageSelectIndex0State({required this.index});
}

class HomePageSelectIndex1State extends HomePageState {
  final int index;

  const HomePageSelectIndex1State({required this.index});
}

class HomePageSelectIndex2State extends HomePageState {
  final int index;

  const HomePageSelectIndex2State({required this.index});
}

class HomePageSelectIndex3State extends HomePageState {
  final int index;

  const HomePageSelectIndex3State({required this.index});
}
