part of 'cal_move_time_bloc.dart';

sealed class CalMoveTimeState {}

class CalMoveTimeInitial extends CalMoveTimeState {
  final List<CalMoveTime>? moveTime;

  CalMoveTimeInitial({this.moveTime = const []});
}

class CalMoveTimeInProgress extends CalMoveTimeState {
  final bool loading;

  CalMoveTimeInProgress({this.loading = true});
}

class CalMoveTimeSuccess extends CalMoveTimeState {
  final List<CalMoveTime>? moveTime;

  CalMoveTimeSuccess({this.moveTime});
}

class CalMoveTimeFailure extends CalMoveTimeState {
  final List<CalMoveTime>? moveTime;

  CalMoveTimeFailure({this.moveTime = const []});
}
