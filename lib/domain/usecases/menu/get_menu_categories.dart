import 'package:dartz/dartz.dart';
import 'package:menu_servex/core/usecase/usecase.dart';
import 'package:menu_servex/domain/repository/menu/menu.dart';
import 'package:menu_servex/service_locator.dart';

class GetMenuCategoriesUsecase implements Usecase<Either,dynamic>{
  @override
  Future<Either> call({param}) async{
    return await sl<MenuRepository>().getMenuCategories();
  }
}