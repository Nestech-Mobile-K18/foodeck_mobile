import 'package:template/source/export.dart';

part 'restaurant_page_event.dart';
part 'restaurant_page_state.dart';

class RestaurantPageBloc
    extends Bloc<RestaurantPageEvent, RestaurantPageState> {
  RestaurantPageBloc() : super(RestaurantPageInitial()) {
    on<RestaurantPageInitialEvent>(restaurantPageInitialEvent);
    on<RestaurantPageShareEvent>(restaurantPageShareEvent);
    on<RestaurantPageReportEvent>(restaurantPageReportEvent);
    on<RestaurantPageReviewEvent>(restaurantPageReviewEvent);
    on<RestaurantPageMapEvent>(restaurantPageMapEvent);
    on<RestaurantPageNavigateEvent>(restaurantPageNavigateEvent);
    on<RestaurantPageBackEvent>(restaurantPageBackEvent);
  }

  FutureOr<void> restaurantPageInitialEvent(RestaurantPageInitialEvent event,
      Emitter<RestaurantPageState> emit) async {
    emit(RestaurantPageLoadingState());
    await Future.delayed(const Duration(milliseconds: 2));
    emit(RestaurantPageLoadingSuccessState(
        restaurant: RestaurantData.restaurant));
  }

  FutureOr<void> restaurantPageBackEvent(
      RestaurantPageBackEvent event, Emitter<RestaurantPageState> emit) {
    emit(RestaurantPageBackState());
  }

  FutureOr<void> restaurantPageShareEvent(
      RestaurantPageShareEvent event, Emitter<RestaurantPageState> emit) {
    emit(RestaurantPageShareState());
  }

  FutureOr<void> restaurantPageReportEvent(
      RestaurantPageReportEvent event, Emitter<RestaurantPageState> emit) {
    emit(RestaurantPageReportState());
  }

  FutureOr<void> restaurantPageReviewEvent(
      RestaurantPageReviewEvent event, Emitter<RestaurantPageState> emit) {
    emit(RestaurantPageReviewState());
  }

  FutureOr<void> restaurantPageMapEvent(
      RestaurantPageMapEvent event, Emitter<RestaurantPageState> emit) {
    emit(RestaurantPageMapState());
  }

  FutureOr<void> restaurantPageNavigateEvent(
      RestaurantPageNavigateEvent event, Emitter<RestaurantPageState> emit) {
    emit(RestaurantPageNavigateState());
  }
}
