class CalMoveTime {
  final int id;
  final double distance;
  final int time;
  final String unit;
  final String unitDistance;

  CalMoveTime(
      { this.id=0,
       this.distance=0,
       this.time=0,
       this.unit='',
       this.unitDistance=''});

  factory CalMoveTime.fromJson(Map<String, dynamic> json) {
    return CalMoveTime(
      id: json['id'] ?? 0,
      distance: json['distance'].toDouble() ?? 0.0,
      time: json['time'] ?? 0,
      unit: json['unit'] ?? '',
      unitDistance: json['unit_distance'] ?? '',
    );
  }
}

List<CalMoveTime> mapResponseToCalMoveTimeList(dynamic response) {
  List<CalMoveTime> calMoveTimes = [];

  if (response is List) {
    for (var item in response) {
      if (item is Map<String, dynamic>) {
        CalMoveTime calMoveTime = CalMoveTime.fromJson(item);
        calMoveTimes.add(calMoveTime);
      }
    }
  }

  return calMoveTimes;
}
