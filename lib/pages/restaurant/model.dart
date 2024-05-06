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
    final String image;
  final List<FoodType> type;
  final int quanity;
  final String note;
  final List<FoodExtra> extra;
  final double totalPrice;

  const FoodInfo(
      this.type, this.quanity, this.note, this.extra, this.totalPrice, this.name, this.address, this.isFavourite, this.image);
}

class FoodType {
  final String typeId;
  final String typeName;
  final double typePrice;

  const FoodType(this.typeId, this.typeName, this.typePrice);
}

class FoodExtra {
  final String extraId;
  final String extraName;
  final double extraPrice;

  const FoodExtra(this.extraId, this.extraName, this.extraPrice);
}
