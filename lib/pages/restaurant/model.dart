class RestaurantInfo {
  final String id;
  final String image;
  final String name;
  final String address;
  final bool isFavourite;
  final double rate;
  const RestaurantInfo(
    this.id,
    this.image,
    this.name,
    this.address,
    this.isFavourite,
    this.rate,
  );
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

class FoodType {
  final String typeId;
  final String typeName;
  final double typePrice;

  const FoodType({required this.typeId, required this.typeName, required this.typePrice});
}

class FoodExtra {
  final String extraId;
  final String extraName;
  final double extraPrice;

  const FoodExtra({required this.extraId, required this.extraName, required this.extraPrice});
}
