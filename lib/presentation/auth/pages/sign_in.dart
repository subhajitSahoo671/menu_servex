import 'package:flutter/material.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/data/model/auth/sign_in.dart';
import 'package:menu_servex/data/model/auth/sign_up.dart';
import 'package:menu_servex/domain/usecases/auth/sign_in.dart';
import 'package:menu_servex/domain/usecases/auth/sign_up.dart';
import 'package:menu_servex/presentation/auth/pages/sign_up.dart';
import 'package:menu_servex/common/custom_snackbar.dart';
import 'package:menu_servex/presentation/auth/widgets/custom_text_feild.dart';
import 'package:menu_servex/presentation/auth/widgets/employee_dialog.dart';
import 'package:menu_servex/presentation/home/pages/home_page.dart';
import 'package:menu_servex/presentation/landing/landing_page.dart';
import 'package:menu_servex/presentation/waiter/signIn/sign_in.dart';
import 'package:menu_servex/service_locator.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // final String tableNum;
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

        bool isEmployeeDialogOpen = false;

        @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => {
              if(isEmployeeDialogOpen){
                  setState(() {
                    isEmployeeDialogOpen = false;
                  })
              }
            },
            child: Container(
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
                      SizedBox(height: 70),
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
                                color: AppColors.gold,
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
                                color: AppColors.gold,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                           
                      RichText(
                        text: TextSpan(
                          text: "Welcome ",
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                            fontStyle: .italic
                          ),
                          children: [
                            TextSpan(
                          text: " Back !",
                          style: TextStyle(
                            color: AppColors.bg,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontStyle: .normal 
                          ),)
                          ]
                        ),
                      ),
                      ],
                     ),
                      SizedBox(height: 30),
                      _customerDetails(),
                      SizedBox(height: 50),
                      _signInButton(context),
                      SizedBox(height: 100,),
                       Row(
                        mainAxisAlignment: .center,
                        children: [
                       
                         Text(
                          "Don't have an account? ",
                          style: TextStyle(
                             color: AppColors.bg,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          
                        ),
                        
                      
                       GestureDetector(
                        onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                         child: Text(
                             "Sign Up",
                            style: TextStyle(
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                       ),
                        ],
                       )
                    ],
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          // top: 10,
          right: 10,
          child: SafeArea(
            child: OutlinedButton(
                    
                    onPressed: () {
                      setState(() {
                        isEmployeeDialogOpen = !isEmployeeDialogOpen;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                      side: BorderSide(
                        color: AppColors.primaryOrange,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    
                     child:  Text(
                      "Empl",
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
          ),
        ) ,

      if(isEmployeeDialogOpen) Positioned(
          top: 85,
          right: 15,
          child: EmployeeDialog())
        ],
      ),
    );
  }

  Widget _customerDetails() {
  // Color gold = Color(0xFFC58A2B);
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 500),
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(AppColors.gold, BlendMode.color),
          fit: BoxFit.cover,
          image: AssetImage(AppImages.customerDetailsBG),
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: AppColors.gold, blurRadius: 3)],
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
              icon: Icons.mail_outline_outlined
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
    //  Color AppColors.primaryOrange = Color(0xFFC46A14);
    return GestureDetector(
      onTap: () async{
        var res = await sl<SignInUsecase>().call(param: SignInModel(email: _emailController.text.trim(), password: _passwordController.text.trim()));
     
     res.fold((l) {
              context.showSnackBar(message: l.toString(), backgroundColor: Colors.red);

       
     }, (r) {

      
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
                context.showSnackBar(message: r.toString(), backgroundColor: Colors.green);

     },);
      },
      child: Container(
        // height: 50,
        width: double.infinity,
        constraints: BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          color: AppColors.primaryOrange,
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
              color: Color(0xffF5F3E4),
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
