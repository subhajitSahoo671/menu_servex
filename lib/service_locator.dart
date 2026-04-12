
import 'package:get_it/get_it.dart';
import 'package:menu_servex/data/data_sources/menu/menu_firebase_servise.dart';
import 'package:menu_servex/data/repository/menu/menu_repository_impl.dart';
import 'package:menu_servex/domain/repository/menu/menu.dart';
import 'package:menu_servex/domain/usecases/menu/get_menu_categories.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async{
    sl.registerSingleton<MenuFirebaseServise>(MenuFirebaseServiseImpl());

    sl.registerSingleton<MenuRepository>(MenuRepositoryImpl());

    sl.registerSingleton<GetMenuCategoriesUsecase>(GetMenuCategoriesUsecase());

   
}