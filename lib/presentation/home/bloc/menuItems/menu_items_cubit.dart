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
    if (isClosed) return;

    try {
      final data = await sl<GetMenuItemsUsecase>().call().timeout(const Duration(seconds: 20));
      if (isClosed) return;

      return data.fold((l) {
        log("getMenuItems failed: $l");
        if (isClosed) return;
        emit(MenuItemsFailure());
      }, (r) {
        // log("getMenuItems success: $r items");
        if (isClosed) return;
        emit(MenuItemsLoaded(items: r));
      });
    } catch (e) {
      log("getMenuItems timeout or error: $e");
      if (isClosed) return;
      emit(MenuItemsFailure());
    }
  }

  
}