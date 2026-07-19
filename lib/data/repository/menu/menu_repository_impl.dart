import 'package:dartz/dartz.dart';
import 'package:menu_servex/data/data_sources/menu/menu_firebase_servise.dart';
import 'package:menu_servex/domain/repository/menu/menu.dart';
import 'package:menu_servex/service_locator.dart';

class MenuRepositoryImpl extends MenuRepository {
  @override
  Future<Either> getMenuItems() async{
       return await sl<MenuFirebaseServise>().getMenuItems();

  }
  
  @override
  Future<Either> getMenuCategories() async{
    return await sl<MenuFirebaseServise>().getMenuCategories();
  }
}