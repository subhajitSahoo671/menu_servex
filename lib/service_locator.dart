
import 'package:get_it/get_it.dart';
import 'package:menu_servex/data/data_sources/auth/auth_firebase_servise.dart';
import 'package:menu_servex/data/data_sources/cook/auth/cook_auth_firebase_servise.dart';
import 'package:menu_servex/data/data_sources/cook/orders/cook_orders_firebase_servise.dart';
import 'package:menu_servex/data/data_sources/menu/menu_firebase_servise.dart';
import 'package:menu_servex/data/data_sources/orders/orders_firebase_servise.dart';
import 'package:menu_servex/data/data_sources/waiter/auth/waiter_auth_firebase_servise.dart';
import 'package:menu_servex/data/data_sources/waiter/orders/waiter_orders_firebase_servise.dart';
import 'package:menu_servex/data/repository/auth/auth.dart';
import 'package:menu_servex/data/repository/cook/auth/auth.dart';
import 'package:menu_servex/data/repository/cook/orders/orders.dart';
import 'package:menu_servex/data/repository/menu/menu_repository_impl.dart';
import 'package:menu_servex/data/repository/orders/orders.dart';
import 'package:menu_servex/data/repository/waiter/auth/auth.dart';
import 'package:menu_servex/data/repository/waiter/orders/orders.dart';
import 'package:menu_servex/domain/repository/auth/auth.dart';
import 'package:menu_servex/domain/repository/cook/auth/auth.dart';
import 'package:menu_servex/domain/repository/cook/orders/orders.dart';
import 'package:menu_servex/domain/repository/menu/menu.dart';
import 'package:menu_servex/domain/repository/orders/orders.dart';
import 'package:menu_servex/domain/repository/waiter/auth/auth.dart';
import 'package:menu_servex/domain/repository/waiter/orders/orders.dart';
import 'package:menu_servex/domain/usecases/auth/access_token.dart';
import 'package:menu_servex/domain/usecases/auth/sign_in.dart';
import 'package:menu_servex/domain/usecases/auth/sign_up.dart';
import 'package:menu_servex/domain/usecases/cook/auth/sign_in.dart';
import 'package:menu_servex/domain/usecases/cook/orders/get_orders.dart';
import 'package:menu_servex/domain/usecases/cook/orders/update_status.dart';
import 'package:menu_servex/domain/usecases/menu/get_menu_categories.dart';
import 'package:menu_servex/domain/usecases/menu/get_menu_items.dart';
import 'package:menu_servex/domain/usecases/orders/confirm_orders_details.dart';
import 'package:menu_servex/domain/usecases/orders/get_user_orders.dart';
import 'package:menu_servex/domain/usecases/waiter/auth/sign_in.dart';
import 'package:menu_servex/domain/usecases/waiter/orders/get_orders.dart';
import 'package:menu_servex/domain/usecases/waiter/orders/update_status.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async{
    sl.registerSingleton<MenuFirebaseServise>(MenuFirebaseServiseImpl());

    sl.registerSingleton<AuthFirebaseServise>(AuthFirebaseServiseImpl());

    sl.registerSingleton<OrdersFirebaseServise>(OrdersFirebaseServiseImpl());

    sl.registerSingleton<WaiterOrdersFirebaseServise>(WaiterOrdersFirebaseServiseImpl());

    sl.registerSingleton<WaiterAuthFirebaseServise>(WaiterAuthFirebaseServiseImpl());

    sl.registerSingleton<CookOrdersFirebaseServise>(CookOrdersFirebaseServiseImpl());

    sl.registerSingleton<CookAuthFirebaseServise>(CookAuthFirebaseServiseImpl());

    sl.registerSingleton<MenuRepository>(MenuRepositoryImpl());

    sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

    sl.registerSingleton<OrdersRepository>(OrdersRepositoryImpl());

    sl.registerSingleton<WaiterOrdersRepository>(WaiterOrdersRepositoryImpl());

    sl.registerSingleton<WaiterAuthRepository>(WaiterAuthRepositoryImpl());

    sl.registerSingleton<CookOrdersRepository>(CookOrdersRepositoryImpl());

    sl.registerSingleton<CookAuthRepository>(CookAuthRepositoryImpl());

    sl.registerSingleton<GetMenuCategoriesUsecase>(GetMenuCategoriesUsecase());

    sl.registerSingleton<GetMenuItemsUsecase>(GetMenuItemsUsecase());

    sl.registerSingleton<SignInUsecase>(SignInUsecase());

    sl.registerSingleton<SignUpUsecase>(SignUpUsecase());

    sl.registerSingleton<GetUserOrdersUsecase>(GetUserOrdersUsecase());

    sl.registerSingleton<ConfirmOrdersDetailsUsecase>(ConfirmOrdersDetailsUsecase());

    sl.registerSingleton<UpdateStatusUsecase>(UpdateStatusUsecase());

    sl.registerSingleton<GetOrdersUsecase>(GetOrdersUsecase());

    sl.registerSingleton<WaiterSignInUsecase>(WaiterSignInUsecase());

    sl.registerSingleton<UpdateCookStatusUsecase>(UpdateCookStatusUsecase());

    sl.registerSingleton<GetCookOrdersUsecase>(GetCookOrdersUsecase());

    sl.registerSingleton<CookSignInUsecase>(CookSignInUsecase());

    // sl.registerSingleton<AccessTokenUsecase>(AccessTokenUsecase());

}