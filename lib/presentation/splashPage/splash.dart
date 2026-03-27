import 'package:flutter/material.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/presentation/customer_details/pages/customer_details.dart';

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
      body: Center(
        child: Image.asset(AppImages.splashLogo,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> _redirect() async{
      await Future.delayed(Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Customerdetails() ,));
  }
}