part of 'profile_page_bloc.dart';

@immutable
sealed class ProfilePageEvent {}

class ProfilePageInitialEvent extends ProfilePageEvent {
  final String image, name, address;

  ProfilePageInitialEvent(
      {required this.image, required this.name, required this.address});
}

class ProfilePageNavigateEvent extends ProfilePageEvent {
  final BuildContext context;
  final int index;
  final KindSetting type;
  final String gate;

  ProfilePageNavigateEvent(
      {required this.context,
      required this.index,
      required this.type,
      required this.gate});
}

class ProfilePageToggleThemeEvent extends ProfilePageEvent {}

class ProfilePageLogOutEvent extends ProfilePageEvent {}
