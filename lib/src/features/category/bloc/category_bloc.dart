import 'package:bloc/bloc.dart';
import 'package:template/src/features/category/data/model.dart';
import 'package:template/src/services/category_service.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService _categoryService;

  CategoryBloc(this._categoryService) : super(CategoryInitial()) {
    on<CategoryInforStarted>(_onCategoriesInforStarted);
  }

  Future<void> _onCategoriesInforStarted(
      CategoryInforStarted event, Emitter<CategoryState> emit) async {
    emit(CategoryListInProgress());
    try {
      print('CalMoveTimeStarted');
      List<CategoryInfo>? response = await _categoryService
          .getCategories(CategoryResquest(idRestaurant: event.idRestaurant));
      print('response res $response');
      emit(CategoryListSuccess(categories: response));
    } catch (e) {
      emit(CategoryListFailure());
    }
  }
}
