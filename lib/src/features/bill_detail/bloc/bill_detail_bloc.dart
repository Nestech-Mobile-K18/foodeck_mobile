import 'package:bloc/bloc.dart';

part 'bill_detail_event.dart';
part 'bill_detail_state.dart';

class BillDetailBloc extends Bloc<BillDetailEvent, BillDetailState> {
  BillDetailBloc() : super(BillDetailInitial()) {
   on<BillDetailStarted>(_onRestaurantInforStarted);
  }

  // get bill detail
  Future<void> _onRestaurantInforStarted(
      BillDetailStarted event, Emitter<BillDetailState> emit) async {
    emit(BillDetailInProgress());
    try {
      // String? response = await _authService.loginEmail(request);

      emit(BillDetailSuccess(id: event.id));
    } catch (e) {
      emit(BillDetailFailure());
    }
  }
}
