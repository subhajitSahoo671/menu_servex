import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:menu_servex/firebase_options.dart';
import 'package:menu_servex/presentation/auth/pages/auth_wrapper.dart';
import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';
import 'package:menu_servex/presentation/favorite/bloc/favorite_items_cubit.dart';
import 'package:menu_servex/presentation/splashPage/splash.dart';
import 'package:menu_servex/service_locator.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await initializeDependencies();

   // Initialize native storage directory
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        :  HydratedStorageDirectory(
            (await getTemporaryDirectory()).path,
          ),
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(providers: [
       BlocProvider<CartItemsCubit>(create: (context) =>  CartItemsCubit()..getCartItemsList(),),
       BlocProvider<FavoriteItemsCubit>(create: (context) =>  FavoriteItemsCubit(),),
    ],
      child: MaterialApp(
        title: 'ServeX',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF6C3823)),
        ),
        home: const AuthWrapper(),
      ),
    
    );
  }
}

