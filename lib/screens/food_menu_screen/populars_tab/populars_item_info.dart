class PopularsItemInfo {
  final int id;
  final String image;
  final String name;
  final String detail;
  final String price;
  late String location;
  late String store;

  PopularsItemInfo({
    required this.id,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    required this.location,
    required this.store,
  });
}

List<PopularsItemInfo> popularsItemInfo = [
  PopularsItemInfo(
    id: 1,
    image: "assets/images/populars/populars_1.png",
    name: "Chicken Fajita Pizza",
    detail: "8” pizza with regular soft drink",
    price: "\$10",
    location: '',
    store: '',
  ),
  PopularsItemInfo(
    id: 2,
    image: "assets/images/populars/populars_2.png",
    name: "Chicken Fajita Pizza",
    detail: "8” pizza with regular soft drink",
    price: "\$10",
    location: '',
    store: '',
  ),
];
