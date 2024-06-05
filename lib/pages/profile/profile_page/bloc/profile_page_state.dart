part of 'profile_page_bloc.dart';

@immutable
sealed class ProfilePageState {}

class ProfilePageActionState extends ProfilePageState {}

final class ProfilePageInitial extends ProfilePageState {}

class ProfilePageLoadingState extends ProfilePageState {}

class ProfilePageLoadedState extends ProfilePageState {
  final String? image, name, address;
  final bool load;

  ProfilePageLoadedState(
      {required this.image,
      required this.name,
      required this.address,
      required this.load});
}

class ProfilePageNavigateState extends ProfilePageActionState {}

class ProfilePageToggleThemeState extends ProfilePageState {}

class ProfilePageLogOutState extends ProfilePageActionState {}
