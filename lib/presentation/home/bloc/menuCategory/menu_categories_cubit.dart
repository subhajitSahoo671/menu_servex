import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_servex/domain/usecases/menu/get_menu_categories.dart';
import 'package:menu_servex/presentation/home/bloc/menuCategory/menu_categories_state.dart';
import 'package:menu_servex/service_locator.dart';

class MenuCategoriesCubit extends Cubit<MenuCategoriesState>{
  MenuCategoriesCubit() : super(MenuCategoriesLoading()){
    // log("MenuCategoriesCubit created, emitting loading");
  }

  Future<void> getMenuCategories() async{
    // log("getMenuCategories called");
    try {
      var data = await sl<GetMenuCategoriesUsecase>().call().timeout(const Duration(seconds: 20));
      return data.fold((l) {
        log("getMenuCategories failed: $l");
        emit(MenuCategoriesFailure());
      }, (r) {
        // log("getMenuCategories success: $r categories");
        emit(MenuCategoriesLoaded(categories: r));
      },);
    } catch (e) {
      log("getMenuCategories timeout or error: $e");
      emit(MenuCategoriesFailure());
    }
  }

  
}