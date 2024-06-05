import 'package:template/source/export.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  ProfilePageBloc() : super(ProfilePageInitial()) {
    on<ProfilePageInitialEvent>(profilePageInitialEvent);
    on<ProfilePageNavigateEvent>(profilePageNavigateEvent);
    on<ProfilePageToggleThemeEvent>(profilePageToggleThemeEvent);
    on<ProfilePageLogOutEvent>(profilePageLogOutEvent);
  }

  FutureOr<void> profilePageInitialEvent(
      ProfilePageInitialEvent event, Emitter<ProfilePageState> emit) {
    emit(ProfilePageLoadedState(
        image: event.image,
        name: event.name,
        address: event.address,
        load: false));
  }

  FutureOr<void> profilePageNavigateEvent(
      ProfilePageNavigateEvent event, Emitter<ProfilePageState> emit) {
    RiveUtils.changeSMITriggerState(RestaurantData.kindSetting(
            event.type, RiveUtils.profileIcons)[event.index]
        .statusTrigger!);
    check(event.gate, event.context);
    emit(ProfilePageNavigateState());
    emit(ProfilePageLoadedState(
        image: sharedPreferences.getString('avatar')!,
        name: sharedPreferences.getString('name')!,
        address: sharedPreferences.getString('currentAddress')!,
        load: false));
  }

  FutureOr<void> profilePageToggleThemeEvent(
      ProfilePageToggleThemeEvent event, Emitter<ProfilePageState> emit) {}

  FutureOr<void> profilePageLogOutEvent(
      ProfilePageLogOutEvent event, Emitter<ProfilePageState> emit) async {
    AppRouter.navigatorKey.currentState!.pop();
    await Future.delayed(const Duration(milliseconds: 200));
    emit(ProfilePageLoadedState(
        image: sharedPreferences.getString('avatar')!,
        name: sharedPreferences.getString('name')!,
        address: sharedPreferences.getString('currentAddress')!,
        load: true));
    await Future.delayed(
        const Duration(milliseconds: 2000), () => supabase.auth.signOut());
    emit(ProfilePageLogOutState());
  }

  void check(String index, BuildContext context) {
    switch (index) {
      case 'Edit Account':
        AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.editAccount);
        break;
      case 'My Locations':
        AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.myLocation);
        break;
      case 'My Orders':
        AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.myOrders);
        break;
      case 'Payment Methods':
        AppRouter.navigatorKey.currentState!
            .pushNamed(AppRouter.paymentMethods);
        break;
      case 'My Reviews':
        AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.myReviews);
        break;
      case 'About Us':
        CustomWidgets.customSnackBar(
            context, AppColor.buttonShadowBlack, 'In Updating...');
        break;
      case 'Data Usage':
        CustomWidgets.customSnackBar(
            context, AppColor.buttonShadowBlack, 'In Updating...');
        break;
    }
  }
}
