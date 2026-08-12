import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_servex/firebase_options.dart';
import 'package:menu_servex/presentation/auth/pages/auth_wrapper.dart';
import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';
import 'package:menu_servex/presentation/splashPage/splash.dart';
import 'package:menu_servex/service_locator.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await initializeDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider<CartItemsCubit>(
      create: (context) =>  CartItemsCubit()..getCartItemsList(),
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

