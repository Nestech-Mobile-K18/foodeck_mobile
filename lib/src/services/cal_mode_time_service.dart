import 'package:template/main.dart';
import 'package:template/src/features/cal_move_time/data/model.dart';

class CalMoveTimeService {
  Future<List<CalMoveTime>?> getCalMoveTime() async {
    try {
      List<Map<String, dynamic>> data =
          // await supabase.from('restaurant').select('id, id_address, address(id)');
          await supabase.from('cal_move_time').select();
      print('data $data');

      List<CalMoveTime> calMoveTime = mapResponseToCalMoveTimeList(data);
      print('calMoveTime $calMoveTime');
      return calMoveTime;
    } catch (error) {
      return [];
    }
  }
}
