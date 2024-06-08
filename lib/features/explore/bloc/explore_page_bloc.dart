import 'package:template/source/export.dart';

part 'explore_page_event.dart';
part 'explore_page_state.dart';

class ExplorePageBloc extends Bloc<ExplorePageEvent, ExplorePageState> {
  ExplorePageBloc() : super(ExplorePageInitial()) {
    on<ExplorePageInitialEvent>(explorePageInitialEvent);
    on<ExplorePageSearchNavigateEvent>(explorePageSearchNavigateEvent);
    on<ExplorePageNavigateEvent>(explorePageNavigateEvent);
    on<ExplorePageCartNavigateEvent>(explorePageCartNavigateEvent);
    on<ExplorePageLikeEvent>(explorePageLikeEvent);
  }

  // Convert latitude and longitude to address
  void setAddress() async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        getLatLngFromSharedPrefs().latitude,
        getLatLngFromSharedPrefs().longitude);
    Placemark place = placeMarks[0];
    sharedPreferences.setString(
        'currentAddress', '${place.street}, ${place.subAdministrativeArea}');
  }

  void toggleSave(ExplorePageLikeEvent event) {
    if (!SavedListData.saveFood.contains(event.saveFood)) {
      SavedListData.saveFood.add(event.saveFood);
    } else {
      SavedListData.saveFood.remove(event.saveFood);
    }
  }

  FutureOr<void> explorePageInitialEvent(
      ExplorePageInitialEvent event, Emitter<ExplorePageState> emit) {
    setAddress();
    emit(ExplorePageLoadingState());
    emit(ExplorePageLoadingSuccessState());
  }

  FutureOr<void> explorePageSearchNavigateEvent(
      ExplorePageSearchNavigateEvent event, Emitter<ExplorePageState> emit) {
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.searchPage);
    emit(ExplorePageSearchNavigateActionState());
  }

  FutureOr<void> explorePageNavigateEvent(
      ExplorePageNavigateEvent event, Emitter<ExplorePageState> emit) {
    sharedPreferences.setString(
        'restaurantName', event.restaurantModel.shopName);
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.restaurantPage,
        arguments: RestaurantPage(restaurant: event.restaurantModel));
    emit(ExplorePageNavigateActionState());
  }

  FutureOr<void> explorePageCartNavigateEvent(
      ExplorePageCartNavigateEvent event, Emitter<ExplorePageState> emit) {
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.restaurantCart);
    emit(ExplorePageCartNavigateActionState());
  }

  FutureOr<void> explorePageLikeEvent(
      ExplorePageLikeEvent event, Emitter<ExplorePageState> emit) {
    emit(ExplorePageLikeState(restaurantModel: event.saveFood));
    toggleSave(event);
  }
}
