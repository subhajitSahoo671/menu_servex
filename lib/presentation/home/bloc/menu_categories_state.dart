import 'package:menu_servex/domain/entity/menu_categories/categories.dart';

abstract class MenuCategoriesState {}

class MenuCategoriesLoading extends MenuCategoriesState{}

class MenuCategoriesLoaded extends MenuCategoriesState{
  final List<CategoriesEntity> categories;
  MenuCategoriesLoaded({required this.categories});

  
}

class MenuCategoriesFailure extends MenuCategoriesState{}