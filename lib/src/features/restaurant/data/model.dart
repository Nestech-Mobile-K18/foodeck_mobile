import 'package:template/src/utils/model/location.dart';

class RestaurantInfo {
  final int id;
  final String idOwner;
  final int idAddress;
  final String name;
  final double rate;
  final String? open;
  final String? close;
  final bool? isOpen;
  final String? image;
  final LocationInfor? address;
  int time;
  String timeUnit;
  final String unitDistance;
  double distance;

  RestaurantInfo({
    this.rate = 0,
    this.id = 0,
    this.idOwner = '',
    this.idAddress = 0,
    this.name = '',
    this.open = '',
    this.close = '',
    this.isOpen = false,
    this.image = '',
    this.address,
    this.time = 0,
    this.distance = 0.0,
    this.timeUnit = '',
    this.unitDistance = 'km',
  });
  factory RestaurantInfo.fromJson(Map<String, dynamic> json) {
    return RestaurantInfo(
      id: json['id'] ?? 0,
      idOwner: json['id_owner'] ?? '',
      idAddress: json['id_address'] ?? 0,
      name: json['name'] ?? '',
      rate: json['rate']?.toDouble() ?? 0.0,
      open: json['open_at'],
      close: json['close_at'],
      isOpen: json['is_open'],
      image: json['image'],
      address: json['address'] != null
          ? LocationInfor.fromJson(json['address'])
          : null,
    );
  }
}

List<RestaurantInfo> mapResponseToRestaurantList(dynamic response) {
  List<RestaurantInfo> restaurantList = [];

  if (response is List) {
    for (var item in response) {
      if (item is Map<String, dynamic>) {
        RestaurantInfo restaurant = RestaurantInfo.fromJson(item);
        restaurantList.add(restaurant);
      }
    }
  }

  return restaurantList;
}

class RestaurantRequest {
  final int? size;

  RestaurantRequest({this.size});
}

class CalMoveTime {
  final int id;
  final double distance;
  final int time;
  final String unit;
  final String unitDistance;

  CalMoveTime(
      {required this.id,
      required this.distance,
      required this.time,
      required this.unit,
      required this.unitDistance});

  factory CalMoveTime.fromJson(Map<String, dynamic> json) {
    return CalMoveTime(
      id: json['id'] ?? 0,
      distance: json['distance'].toDouble() ?? 0.0,
      time: json['time'] ?? '',
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

class FoodInfo {
  final String name;
  final String address;
  final bool isFavourite;
  final String? image;
  final List<FoodType> type;
  final int quanity;
  final String note;
  final List<FoodExtra> extra;
  final double totalPrice;

  const FoodInfo(
      {required this.type,
      required this.quanity,
      required this.note,
      required this.extra,
      required this.totalPrice,
      required this.name,
      required this.address,
      required this.isFavourite,
      this.image});
}

class TimeMove {
  final int time;
  final String unit;

  TimeMove(this.time, this.unit);
}

class FoodType {
  final String typeId;
  final String typeName;
  final double typePrice;

  const FoodType(
      {required this.typeId, required this.typeName, required this.typePrice});
}

class FoodExtra {
  final String extraId;
  final String extraName;
  final double extraPrice;

  const FoodExtra(
      {required this.extraId,
      required this.extraName,
      required this.extraPrice});
}
