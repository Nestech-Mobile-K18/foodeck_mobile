part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomePageSelectIndexEvent extends HomePageEvent {
  final int index;

  const HomePageSelectIndexEvent({required this.index});
}

class HomePageNavigateEvent extends HomePageEvent {}
