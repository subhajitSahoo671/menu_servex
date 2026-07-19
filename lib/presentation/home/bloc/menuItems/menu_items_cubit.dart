import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:menu_servex/domain/usecases/menu/get_menu_categories.dart';
import 'package:menu_servex/domain/usecases/menu/get_menu_items.dart';
import 'package:menu_servex/presentation/home/bloc/menuCategory/menu_categories_state.dart';
import 'package:menu_servex/presentation/home/bloc/menuItems/menu_items_state.dart';
import 'package:menu_servex/service_locator.dart';

class MenuItemsCubit extends Cubit<MenuItemsState>{
  MenuItemsCubit() : super(MenuItemsLoading()){
    // log("MenuCategoriesCubit created, emitting loading");
  }

  Future<void> getMenuItems() async{
    // log("getMenuCategories called");
    try {
      var data = await sl<GetMenuItemsUsecase>().call().timeout(const Duration(seconds: 20));
      return data.fold((l) {
        log("getMenuItems failed: $l");
        emit(MenuItemsFailure());
      }, (r) {
        // log("getMenuItems success: $r items");
        emit(MenuItemsLoaded(items: r));
      },);
    } catch (e) {
      log("getMenuItems timeout or error: $e");
      emit(MenuItemsFailure());
    }
  }

  
}