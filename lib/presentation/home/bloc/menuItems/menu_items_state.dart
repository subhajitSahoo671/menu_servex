// import 'package:menu_servex/domain/entity/menu_categories/categories.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';

abstract class MenuItemsState {}

class MenuItemsLoading extends MenuItemsState{}

class MenuItemsLoaded extends MenuItemsState{
  final List<List<ItemsEntity>> items;
  MenuItemsLoaded({required this.items});

  
}

class MenuItemsFailure extends MenuItemsState{}