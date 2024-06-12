import 'package:template/source/export.dart';

part 'restaurant_page_event.dart';
part 'restaurant_page_state.dart';

class RestaurantPageBloc
    extends Bloc<RestaurantPageEvent, RestaurantPageState> {
  final reviewController = TextEditingController();
  double rate = 1;

  RestaurantPageBloc() : super(RestaurantPageInitial()) {
    on<RestaurantPageInitialEvent>(restaurantPageInitialEvent);
    on<RestaurantPageShareEvent>(restaurantPageShareEvent);
    on<RestaurantPageReportEvent>(restaurantPageReportEvent);
    on<RestaurantPageSetRateEvent>(restaurantPageSetRateEvent);
    on<RestaurantPageSentReviewEvent>(restaurantPageSentReviewEvent);
    on<RestaurantPageMapEvent>(restaurantPageMapEvent);
    on<RestaurantPageNavigateToAddonEvent>(restaurantPageNavigateToAddonEvent);
  }

  FutureOr<void> restaurantPageInitialEvent(
      RestaurantPageInitialEvent event, Emitter<RestaurantPageState> emit) {
    emit(RestaurantPageLoadingState());
    emit(RestaurantPageLoadingSuccessState(restaurant: event.restaurant));
  }

  FutureOr<void> restaurantPageShareEvent(
      RestaurantPageShareEvent event, Emitter<RestaurantPageState> emit) {
    emit(RestaurantPageShareState());
    emit(RestaurantPageLoadingSuccessState(restaurant: event.restaurant));
  }

  FutureOr<void> restaurantPageReportEvent(
      RestaurantPageReportEvent event, Emitter<RestaurantPageState> emit) {
    emit(RestaurantPageReportState());
  }

  FutureOr<void> restaurantPageSetRateEvent(
      RestaurantPageSetRateEvent event, Emitter<RestaurantPageState> emit) {
    rate = event.rate;
    emit(RestaurantPageSetRateState());
  }

  FutureOr<void> restaurantPageSentReviewEvent(
      RestaurantPageSentReviewEvent event, Emitter<RestaurantPageState> emit) {
    sent(event.reviewController, event.context, event.restaurant, event.rate!);
    emit(RestaurantPageSentReviewState());
  }

  FutureOr<void> restaurantPageMapEvent(
      RestaurantPageMapEvent event, Emitter<RestaurantPageState> emit) {
    emit(RestaurantPageMapState());
  }

  FutureOr<void> restaurantPageNavigateToAddonEvent(
      RestaurantPageNavigateToAddonEvent event,
      Emitter<RestaurantPageState> emit) {
    emit(RestaurantPageNavigateToAddonState(
        foodItems: event.foodItems, restaurant: event.restaurant));
    emit(RestaurantPageLoadingSuccessState(restaurant: event.restaurant));
  }

  void sent(TextEditingController reviewController, BuildContext context,
      RestaurantModel restaurant, double rate) {
    if (reviewController.text.isNotEmpty) {
      RiveUtils.changeSMITriggerState(RiveUtils.reviewModel.statusTrigger!);
      addReview(context, reviewController, restaurant, rate);
      Future.delayed(
          const Duration(milliseconds: 3000), () => Navigator.pop(context));
    } else {
      customSnackBar(
          context, Toast.error, 'It\'s empty, Please leave a comment');
    }
  }

  Future addReview(BuildContext context, TextEditingController reviewController,
      RestaurantModel restaurant, double rate) async {
    try {
      if (reviewController.text.isEmpty) {
        return null;
      } else {
        await supabase.from('reviews').insert({
          'restaurant_image': restaurant.image,
          'restaurant_name': restaurant.shopName,
          'time': restaurant.deliveryTime,
          'place': restaurant.address,
          'vote': restaurant.rate,
          'my_vote': rate,
          'my_review': reviewController.text.trim()
        });
      }
    } catch (e) {
      if (context.mounted) {
        customSnackBar(context, Toast.error, e.toString());
      }
    }
  }
}
