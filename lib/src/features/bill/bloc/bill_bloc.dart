import 'package:bloc/bloc.dart';

part 'bill_event.dart';
part 'bill_state.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  BillBloc() : super(BillInitial()) {
    on<BillStarted>(_onFoodInforStarted);
  }

  // get restaurant bill
  Future<void> _onFoodInforStarted(
      BillStarted event, Emitter<BillState> emit) async {
    emit(BillInProgress());
    try {
      // String? response = await _authService.loginEmail(request);

      emit(BillSuccess(
        id: event.id,
      ));
    } catch (e) {
      emit(BillFailure());
    }
  }
}
