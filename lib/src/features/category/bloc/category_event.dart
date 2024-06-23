part of 'category_bloc.dart';

sealed class CategoryEvent {

}
class CategoryInforStarted extends CategoryEvent {
  final int idRestaurant;

  CategoryInforStarted({required this.idRestaurant});
}