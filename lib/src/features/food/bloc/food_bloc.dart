import 'package:bloc/bloc.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitial()) {
    on<FoodStarted>(_onFoodStarted);
  }

  Future<void> _onFoodStarted(
      FoodStarted event, Emitter<FoodState> emit) async {
    try {
      // String? response = await _authService.loginEmail(request);

      emit(FoodSuccess(
          id: event.id, name: '', price: 0, description: '', image: ''));
    } catch (e) {
      emit(FoodFailure());
    }
  }
}
