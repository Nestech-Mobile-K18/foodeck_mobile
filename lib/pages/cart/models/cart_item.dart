class CartItem {
  final String? idFood;
  final String? foodName;
  final String? bonus;
  final String? imageFood;
  final String addressRestaurant;
  final List<String>? extraSauce;
  final String? variation;
  final int? quantity;
  final double? price;

  CartItem({
    required this.idFood,
    required this.foodName,
    required this.bonus,
    required this.imageFood,
    required this.addressRestaurant,
    required this.extraSauce,
    required this.variation,
    required this.quantity,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      idFood: json['id_food'],
      foodName: json['food_name'],
      bonus: json['bonus'],
      imageFood: json['image_food'],
      addressRestaurant: json['address_restaurant'],
      extraSauce: json['extra_sauce'] != null ? List<String>.from(json['extra_sauce']) : [],
      variation: json['variation'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_food': idFood,
      'food_name': foodName,
      'bonus': bonus,
      'image_food': imageFood,
      'address_restaurant': addressRestaurant,
      'extra_sauce': extraSauce,
      'variation': variation,
      'quantity': quantity,
      'price': price,
    };
  }
}
