
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menu_servex/presentation/auth/pages/sign_up.dart';
import 'package:menu_servex/presentation/auth/services/check_user.dart';
import 'package:menu_servex/presentation/cook/dashBoard/pages/cook_dashboard.dart';
import 'package:menu_servex/presentation/home/pages/home_page.dart';
import 'package:menu_servex/presentation/landing/landing_page.dart';
import 'package:menu_servex/presentation/splashPage/splash.dart';
import 'package:menu_servex/presentation/waiter/dashBoard/pages/waiter_dashboard.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});


  Future<String> _checkUserRole() async{
     return await CheckUserService().checkUserRole();
  }

  @override
  Widget build(BuildContext context) {
  
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), 
    builder: (context, snapshot) {

      if (snapshot.connectionState == ConnectionState.waiting) {
      return const SplashPage();
    }
      //user is logged in
       if (snapshot.hasData) {
        return FutureBuilder<String>(
          future: _checkUserRole(),
          builder: (context, roleSnapshot) {
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return const SplashPage();
            }
            if (roleSnapshot.hasData) {
              final role = roleSnapshot.data;
              print("userRole:$role");
              return role == "customer"
                  ? LandingPage()
                  : role == "waiter"
                      ? WaiterDashboard()
                  : role == "cook"
                      ? CookDashboard()
                      : SignUp();
            }
            return SignUp();
          },
        );
      }
      
      //user is not logged in    
      else {
        return SignUp();
      }
    },);
  }
}