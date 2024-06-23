import 'package:template/src/features/category/data/model.dart';
import 'package:template/src/pages/export.dart';

class CategoryService {
  Future<List<CategoryInfo>?> getCategories(CategoryResquest request) async {
    try {
      List<Map<String, dynamic>> data =
          // await supabase.from('restaurant').select('id, id_address, address(id)');
          await supabase.from('category_restaurant').select().eq('id_restaursnt', request.idRestaurant);
      print('data $data');

      List<CategoryInfo> categories = mapResponseCategoryList(data);
      print('categories $categories');
      return categories;
    } catch (error) {
      return [];
    }
  }
}
