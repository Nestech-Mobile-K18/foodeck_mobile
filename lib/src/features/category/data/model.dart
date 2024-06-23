class CategoryInfo {
  final int id;
  final String name;
  final int idRestaurant;

  CategoryInfo({
    this.id = 0,
    this.name = '',
    this.idRestaurant = 0,
  });
  factory CategoryInfo.fromJson(Map<String, dynamic> json) {
    return CategoryInfo(
      id: json['id'] ?? 0,
      idRestaurant: json['id_restaurant'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

List<CategoryInfo> mapResponseCategoryList(dynamic response) {
  List<CategoryInfo> categoryList = [];

  if (response is List) {
    for (var item in response) {
      if (item is Map<String, dynamic>) {
        CategoryInfo category = CategoryInfo.fromJson(item);
        categoryList.add(category);
      }
    }
  }

  return categoryList;
}

class CategoryResquest {
  final int idRestaurant;
  CategoryResquest({required this.idRestaurant});
}
