import 'package:bloc/bloc.dart';
import 'package:template/src/features/cal_move_time/data/model.dart';
import 'package:template/src/services/cal_mode_time_service.dart';

part 'cal_move_time_event.dart';
part 'cal_move_time_state.dart';

class CalMoveTimeBloc extends Bloc<CalMoveTimeEvent, CalMoveTimeState> {
   final CalMoveTimeService _calMoveTimeService;
  CalMoveTimeBloc(this._calMoveTimeService) : super(CalMoveTimeInitial()) {
       on<CalMoveTimeStarted>(_onCalMoveTimeInforStarted);

  }

  // get list to get time move
  Future<void> _onCalMoveTimeInforStarted(
      CalMoveTimeStarted event, Emitter<CalMoveTimeState> emit) async {
    emit(CalMoveTimeInProgress());
    try {
      print('CalMoveTimeStarted');
      List<CalMoveTime>? response = await _calMoveTimeService.getCalMoveTime();
      print('response res $response');
      emit(CalMoveTimeSuccess(moveTime: response));
    } catch (e) {
      emit(CalMoveTimeFailure());
    }
  }
}
