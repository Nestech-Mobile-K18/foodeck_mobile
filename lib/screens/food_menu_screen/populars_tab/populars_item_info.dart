class PopularsItemInfo {
  final int id;
  final String image;
  final String name;
  final String size;
  final String price;

  PopularsItemInfo(
      {required this.id,
      required this.image,
      required this.name,
      required this.size,
      required this.price});
}

List<PopularsItemInfo> popularsItemInfo = [
  PopularsItemInfo(
      id: 1,
      image: "assets/images/populars/populars_1.png",
      name: "Chicken Fajita Pizza",
      size: "8” pizza with regular soft drink",
      price: "\$10"),
  PopularsItemInfo(
      id: 2,
      image: "assets/images/populars/populars_2.png",
      name: "Chicken Fajita Pizza",
      size: "8” pizza with regular soft drink",
      price: "\$10"),
];
