
import 'package:get_it/get_it.dart';
import 'package:menu_servex/data/data_sources/auth/auth_firebase_servise.dart';
import 'package:menu_servex/data/data_sources/menu/menu_firebase_servise.dart';
import 'package:menu_servex/data/data_sources/orders/orders_firebase_servise.dart';
import 'package:menu_servex/data/repository/auth/auth.dart';
import 'package:menu_servex/data/repository/menu/menu_repository_impl.dart';
import 'package:menu_servex/data/repository/orders/orders.dart';
import 'package:menu_servex/domain/repository/auth/auth.dart';
import 'package:menu_servex/domain/repository/menu/menu.dart';
import 'package:menu_servex/domain/repository/orders/orders.dart';
import 'package:menu_servex/domain/usecases/auth/access_token.dart';
import 'package:menu_servex/domain/usecases/auth/sign_in.dart';
import 'package:menu_servex/domain/usecases/auth/sign_up.dart';
import 'package:menu_servex/domain/usecases/menu/get_menu_categories.dart';
import 'package:menu_servex/domain/usecases/menu/get_menu_items.dart';
import 'package:menu_servex/domain/usecases/orders/confirm_orders_details.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async{
    sl.registerSingleton<MenuFirebaseServise>(MenuFirebaseServiseImpl());

    sl.registerSingleton<AuthFirebaseServise>(AuthFirebaseServiseImpl());

    sl.registerSingleton<OrdersFirebaseServise>(OrdersFirebaseServiseImpl());

    sl.registerSingleton<MenuRepository>(MenuRepositoryImpl());

    sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

    sl.registerSingleton<OrdersRepository>(OrdersRepositoryImpl());

    sl.registerSingleton<GetMenuCategoriesUsecase>(GetMenuCategoriesUsecase());

    sl.registerSingleton<GetMenuItemsUsecase>(GetMenuItemsUsecase());

    sl.registerSingleton<SignInUsecase>(SignInUsecase());

    sl.registerSingleton<SignUpUsecase>(SignUpUsecase());

    sl.registerSingleton<ConfirmOrdersDetailsUsecase>(ConfirmOrdersDetailsUsecase());

    // sl.registerSingleton<AccessTokenUsecase>(AccessTokenUsecase());

}