class DrinksInfo {
  final String image;
  final double price;
  final String title;
  final String location;

  late bool like;
  DrinksInfo(
      {required this.image,
      required this.price,
      required this.title,
      required this.location,
      required this.like});
}

List<DrinksInfo> drinksInfo = [
  DrinksInfo(
    image: "assets/images/drinks/red_grape_margarita.png",
    price: 18,
    title: "Red Grape Margarita",
    location: "Daily Deli",
    like: false,
  ),
  DrinksInfo(
    image: "assets/images/drinks/lemon_pina_colada.png",
    price: 12,
    title: "Lemon Pina Colada",
    location: "Arfan Juices",
    like: false,
  ),
];
