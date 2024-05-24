class FoodItem {
  final String? idFood;
  final String? foodName;
  final String? imageFood;
  final List<String>? extraSauce;
  final String? variation;

  final int? price;

  FoodItem({
     this.idFood,
     this.foodName,
     this.imageFood,
     this.extraSauce,
     this.variation,

     this.price,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      idFood: json['id_food'],
      foodName: json['food_name'],

      imageFood: json['image_food'],
      extraSauce: json['extra_sauce'] != null ? List<String>.from(json['extra_sauce']) : [],
      variation: json['variation'],

      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_food': idFood,
      'food_name': foodName,
      'image_food': imageFood,
      'extra_sauce': extraSauce,
      'variation': variation,
      'price': price,
    };
  }
}
