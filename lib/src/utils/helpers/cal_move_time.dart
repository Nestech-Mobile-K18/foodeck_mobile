import 'package:template/src/features/restaurant/data/model.dart';

Map<String, dynamic> getTimeMove(
    double distance, List<CalMoveTime> lsCalMoveTime) {
  int index = 0;
  for (int i = 0; index < lsCalMoveTime.length; i++) {
    if (distance < lsCalMoveTime[i].distance) {
      index = i;
      break;
    }
  }

  //TH khoang cach qua xa -> khong ho tro
  if (index >= lsCalMoveTime.length || lsCalMoveTime.isEmpty) {
    return {'time': -1, 'unit': 'm'};
  }
  return {'time': lsCalMoveTime[index].time, 'unit': lsCalMoveTime[index].unit};
}
