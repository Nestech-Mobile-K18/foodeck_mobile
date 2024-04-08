class CartItemInfo {
  final String id;
  final String image;
  final String name;
  final String size;
  final String sauce;
  final int price;
  final int quantity;

  CartItemInfo({
    required this.id,
    required this.image,
    required this.name,
    required this.size,
    required this.sauce,
    required this.price,
    required this.quantity,
  });
}

List<CartItemInfo> cartItemInfo = [];
