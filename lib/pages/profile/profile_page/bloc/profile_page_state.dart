part of 'profile_page_bloc.dart';

@immutable
sealed class ProfilePageState {}

class ProfilePageActionState extends ProfilePageState {}

final class ProfilePageInitial extends ProfilePageState {}

class ProfilePageLoadedState extends ProfilePageState {
  final String? image, name, address;

  ProfilePageLoadedState(
      {required this.image, required this.name, required this.address});
}

class ProfilePageNavigateState extends ProfilePageActionState {}

class ProfilePageToggleThemeState extends ProfilePageState {}

class ProfilePageLogOutState extends ProfilePageActionState {}
