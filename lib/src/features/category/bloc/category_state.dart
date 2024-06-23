part of 'category_bloc.dart';

sealed class CategoryState {}

class CategoryInitial extends CategoryState {
  final List<CategoryInfo> categories;

  CategoryInitial({ this.categories=const []});
}

class CategoryListInProgress extends CategoryState {
  final bool loading;

  CategoryListInProgress({this.loading = true});
}

class CategoryListSuccess extends CategoryState {
  final List<CategoryInfo>? categories;

  CategoryListSuccess({this.categories});
}

class CategoryListFailure extends CategoryState {
  final List<CategoryInfo>? categories;

  CategoryListFailure({this.categories = const []});
}
