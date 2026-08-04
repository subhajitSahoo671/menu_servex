import 'package:flutter/material.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/presentation/auth/pages/auth_wrapper.dart';
import 'package:menu_servex/presentation/customer_details/pages/customer_details.dart';
import 'package:menu_servex/presentation/landing/landing_page.dart';
import 'package:menu_servex/presentation/scanner/scanner.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.splashLogo),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(child: Container(
          height: 200,
          width: 200,
          color: Color(0xffF5F3E4),
          child: Hero(
            tag: 1,
            child: Image.asset(AppImages.logo)))),
      ),
    );
  }

  Future<void> _redirect() async{
      await Future.delayed(Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AuthWrapper() ,));
  }
}