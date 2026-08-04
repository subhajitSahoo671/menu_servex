import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menu_servex/presentation/auth/pages/sign_in.dart';
import 'package:menu_servex/presentation/home/pages/home_page.dart';
import 'package:menu_servex/presentation/landing/landing_page.dart';
import 'package:menu_servex/presentation/splashPage/splash.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), 
    builder: (context, snapshot) {

      if (snapshot.connectionState == ConnectionState.waiting) {
      return const SplashPage();
    }
      //user is logged in
       if (snapshot.hasData) {
        return LandingPage();
      } 
      
      //user is not logged in    
      else {
        return SignIn();
      }
    },);
  }
}