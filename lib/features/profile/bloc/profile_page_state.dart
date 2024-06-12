part of 'profile_page_bloc.dart';

@immutable
sealed class ProfilePageState {}

class ProfilePageActionState extends ProfilePageState {}

final class ProfilePageInitial extends ProfilePageState {}

class ProfilePageLoadedState extends ProfilePageState {
  final Map<String, dynamic> userModel;

  ProfilePageLoadedState({required this.userModel});
}

class ProfilePageUpdatePictureState extends ProfilePageState {
  final String imageUrl;

  ProfilePageUpdatePictureState({required this.imageUrl});
}

class ProfilePageNameInputState extends ProfilePageState {
  final String name;

  ProfilePageNameInputState({required this.name});
}

class ProfilePageEmailInputState extends ProfilePageState {
  final String email;

  ProfilePageEmailInputState({required this.email});
}

class ProfilePagePhoneInputState extends ProfilePageState {
  final String phone;

  ProfilePagePhoneInputState({required this.phone});
}

class ProfilePagePassInputState extends ProfilePageState {
  final String pass;

  ProfilePagePassInputState({required this.pass});
}

class ProfilePageUpdateInfoState extends ProfilePageActionState {
  final String? name, imageUrl;

  ProfilePageUpdateInfoState({required this.name, required this.imageUrl});
}

class ProfilePageErrorState extends ProfilePageState {}

class ProfilePageNavigateState extends ProfilePageActionState {}

class ProfilePageToggleThemeState extends ProfilePageState {}
