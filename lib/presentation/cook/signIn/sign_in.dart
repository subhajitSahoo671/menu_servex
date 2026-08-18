import 'package:flutter/material.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/data/model/auth/sign_in.dart';
import 'package:menu_servex/data/model/auth/sign_up.dart';
import 'package:menu_servex/domain/usecases/auth/sign_in.dart';
import 'package:menu_servex/domain/usecases/auth/sign_up.dart';
import 'package:menu_servex/domain/usecases/cook/auth/sign_in.dart';
import 'package:menu_servex/domain/usecases/waiter/auth/sign_in.dart';
import 'package:menu_servex/presentation/auth/pages/sign_up.dart';
import 'package:menu_servex/common/custom_snackbar.dart';
import 'package:menu_servex/presentation/auth/widgets/custom_text_feild.dart';
import 'package:menu_servex/presentation/cook/dashBoard/pages/cook_dashboard.dart';
import 'package:menu_servex/presentation/home/pages/home_page.dart';
import 'package:menu_servex/presentation/landing/landing_page.dart';
import 'package:menu_servex/presentation/waiter/dashBoard/pages/waiter_dashboard.dart';
import 'package:menu_servex/presentation/waiter/signIn/sign_in.dart';
import 'package:menu_servex/service_locator.dart';

class CookSignIn extends StatelessWidget {
  CookSignIn({super.key});

  // final String tableNum;

  // final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
  Color gold = Color(0xFFC58A2B);
    //  Color primaryColor = Color(0xFFC46A14);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffF5F3E4),
              image: DecorationImage(
                image: AssetImage(AppImages.authBG),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 40),
                   Column(
                    // mainAxisAlignment: .spaceBetween,
                    children: [
                  
                      Hero(
                      tag: 1,
                      child: Image.asset(
                        AppImages.logo,
                        height: 100,
                        width: 100,
                        color: Color.fromARGB(255, 189, 129, 32),
                      ),
                    ),
          
                     SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: gold,
                              thickness: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "GOOD FOOD, GREATE EXPERINCE",
                              style: TextStyle(color: AppColors.bg,fontSize: 12),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: gold,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                         
                    RichText(
                      text: TextSpan(
                        text: "Cook ",
                        style: TextStyle(
                          color: AppColors.bg,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontStyle: .italic 
                        ),
                        children: [
                          TextSpan(
                        text: " Sign In ",
                         style: TextStyle(
                          color: gold,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          fontStyle: .normal
                        ),
                       )
                        ]
                      ),
                    ),
                    // SizedBox(height: 2,),
                     Text(
                              "Sign in to cook and manage your kitchen",
                              style: TextStyle(color: AppColors.bg,fontSize: 15),
                            ),
                    ],
                   ),
                    SizedBox(height: 30),
                    _customerDetails(),
                    SizedBox(height: 60),
                    _signInButton(context),
                    SizedBox(height: 70,),
                  _iAmAWaiter(context),
                  ],
                ),
              ),
            ),
          ),
        IconButton(onPressed: () => Navigator.pop(context),icon: Icon(Icons.arrow_back_ios_new,color: AppColors.gold,size: 24,),),
        ],
      ),
    );
  }

  Widget _customerDetails() {
  Color gold = Color(0xFFC58A2B);
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 500),
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(gold, BlendMode.color),
          fit: BoxFit.cover,
          image: AssetImage(AppImages.customerDetailsBG),
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: gold, blurRadius: 3)],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFeild(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              label: "Email",
              obscureText: false,
              icon: Icons.person_2_outlined
            ),
            SizedBox(height: 20),
            CustomTextFeild(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              label: "Password",
              obscureText: true,
              icon: Icons.lock_outline_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
     Color primaryColor = Color(0xFFC46A14);
    return GestureDetector(
      onTap: () async{
        var res = await sl<CookSignInUsecase>().call(param: SignInModel(email: _emailController.text.trim(), password: _passwordController.text.trim())).timeout(const Duration(seconds: 20));
     
     res.fold((l) {
              context.showSnackBar(message: l.toString(), backgroundColor: Colors.red);

       
     }, (r) {
      
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CookDashboard()),
        );
                context.showSnackBar(message: r.toString(), backgroundColor: Colors.green);

     },);
      },
      child: Container(
        // height: 50,
        width: double.infinity,
        constraints: BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 1,spreadRadius: 3,offset: Offset(0, 3))],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          child: Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.bg,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _iAmAWaiter(BuildContext context){
    //  Color primaryColor = Color(0xFFC46A14);
  Color gold = Color(0xFFC58A2B);

    return  
        Container(
        constraints: BoxConstraints(maxWidth: 500),
          width: double.infinity,
          // height: 52,
          child: OutlinedButton.icon(
            
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WaiterSignIn(),));
            },
            icon:  Icon(
                Icons.person_2_outlined,
                color: gold,
                size: 26,
              ),
            
            style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              side: BorderSide(
                color: gold,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            
             label:  Text(
              "I'm a Waiter",
              style: TextStyle(
                color: gold,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                // letterSpacing: 0.5,
              ),
            ),
          ),
        );
  }
}
