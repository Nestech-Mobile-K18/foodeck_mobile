class CartItem {
  final String? cartId;
  final String? idFood;
  final String? foodName;
  final String? bonus;
  final String? imageFood;
  final String? addressRestaurant;
  final List<String>? extraSauce;
  final String? variation;
  final int? quantity;
  final double? price;
  final String? instructions;
  final String? userEmail;
  final String? userPhone;
  final String? userName;

  CartItem({
    this.cartId,
    this.idFood,
    this.foodName,
    this.bonus,
    this.imageFood,
    this.addressRestaurant,
    this.extraSauce,
    this.variation,
    this.quantity,
    this.price,
    this.instructions,
    this.userEmail,
    this.userPhone,
    this.userName,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartId: json['cart_id'],
      idFood: json['id_food'],
      foodName: json['food_name'],
      bonus: json['bonus'],
      imageFood: json['image_food'],
      addressRestaurant: json['address_restaurant'],
      extraSauce: json['extra_sauce'] != null ? List<String>.from(json['extra_sauce']) : [],
      variation: json['variation'],
      quantity: json['quantity'],
      price: json['price'],
      instructions: json['instructions'],
      userEmail: json['user_email'],
      userPhone: json['user_phone'],
      userName: json['user_name'],
    );
  }

// Function to convert from CartItem to Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'cart_id': cartId,
      'id_food': idFood,
      'food_name': foodName,
      'bonus': bonus,
      'image_food': imageFood,
      'address_restaurant': addressRestaurant,
      'extra_sauce': extraSauce,
      'variation': variation,
      'quantity': quantity,
      'price': price,
      'instructions': instructions,
      'user_email': userEmail,
      'user_phone': userPhone,
      'user_name': userName,
    };
  }
}

// Convert CartItem list to List<Map<String, dynamic>> list
List<Map<String, dynamic>> cartItemListToMapList(List<CartItem> cartItems) {
  return cartItems.map((cartItem) => cartItem.toJson()).toList();
}
