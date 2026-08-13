import 'package:flutter/material.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/presentation/cook/signIn/sign_in.dart';
import 'package:menu_servex/presentation/waiter/signIn/sign_in.dart';


class EmployeeDialog extends StatelessWidget {
  const EmployeeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
          animateColor: true,
          borderRadius:  BorderRadius.circular(30),
          borderOnForeground: true,
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.bg,
        //         image: DecorationImage(
        //   colorFilter: ColorFilter.mode(AppColors.gold, BlendMode.color),
        //   fit: BoxFit.cover,
        //   image: AssetImage(AppImages.customerDetailsBG),
        // ),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: .only(left: 18, right: 24, top: 18, bottom: 18),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WaiterSignIn(),));
                  },
                  child: Text("Waiter LogIn",style: TextStyle(fontSize: 18,fontWeight: .w400,color: AppColors.textSecondary),)),
            SizedBox(
              height: 10,
              child: Divider(
                  color: AppColors.gold.withAlpha(150),
                  // height: 30,
                  radius: BorderRadius.circular(30),
                  thickness: 0.3,
                ),
            ),
                InkWell(
                  onTap: () => 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CookSignIn(),)),
                  child: Text("Cook LogIn",style: TextStyle(fontSize: 18,fontWeight: .w400,color: AppColors.textSecondary),)),
            SizedBox(
              height: 10,
              child: Divider(
                  color: AppColors.gold.withAlpha(150),
                  // height: 30,
                  radius: BorderRadius.circular(30),
                  thickness: 0.3,
                ),
            ),
                Text("Manager LogIn",style: TextStyle(fontSize: 18,fontWeight: .w400,color: AppColors.textSecondary),),
              ],
            ),
          ),
        );
  }
}