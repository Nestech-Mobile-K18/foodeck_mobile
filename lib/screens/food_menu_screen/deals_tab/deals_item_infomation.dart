class DealsItemInfomation {
  final int id;
  final String image;
  final String name;
  final String detail;
  final String price;

  DealsItemInfomation(
      {required this.id,
      required this.image,
      required this.name,
      required this.detail,
      required this.price});
}

List<DealsItemInfomation> dealsItemInfomation = [
  DealsItemInfomation(
      id: 1,
      image: "assets/images/deals/deals_1.png",
      name: "Deal 1",
      detail: "1 regular burger with croquette and hot cocoa",
      price: "\$12"),
  DealsItemInfomation(
      id: 2,
      image: "assets/images/deals/deals_2.png",
      name: "Deal 2",
      detail: "1 regular burger with small fries",
      price: "\$6"),
  DealsItemInfomation(
      id: 3,
      image: "assets/images/deals/deals_3.png",
      name: "Deal 3",
      detail: "2 pieces of beef stew with homemade sauce",
      price: "\$23"),
];
