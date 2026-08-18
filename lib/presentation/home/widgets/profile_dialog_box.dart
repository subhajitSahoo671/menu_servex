import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/presentation/auth/pages/sign_in.dart';
import 'package:menu_servex/presentation/favorite/page/favorite_page.dart';
import 'package:menu_servex/presentation/home/widgets/about_dialog_box.dart';
import 'package:menu_servex/presentation/orders/pages/all_orders.dart';

class ProfileDialogBox extends StatelessWidget {
  const ProfileDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> signedOut() async {
      try {
        await FirebaseAuth.instance.signOut();
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
        print("User successfully signed out");
      } catch (e) {
        print("Error signing out: $e");
      }
    }

    return Hero(
      tag: "dialog",
      child: Dialog(
        insetAnimationCurve: Curves.bounceInOut,
        insetAnimationDuration: Duration(milliseconds: 300),
        surfaceTintColor: AppColors.textPrimary,
        shadowColor: AppColors.bg,
        elevation: 20,
        insetPadding: .symmetric(horizontal: 16),
        backgroundColor: AppColors.bg,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          constraints: BoxConstraints(maxHeight: 600, maxWidth: 1200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.bg,
          ),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: CloseButton(color: AppColors.primary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "subhajit sahoo",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: .w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      "subhajitsahoo@gmail.com",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: .w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 32),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildList(
                            Icons.assignment,
                            "My Orders",
                            () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllOrdersScreen(),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildList(
                            Icons.favorite_border,
                            "My WishList",
                            () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FavoritePage(),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildList(Icons.payment, "Payment Methods", () {}),
                          SizedBox(height: 16),
                          _buildList(
                            Icons.info_outline_rounded,
                            "About Us",
                            () {
                              Navigator.pop(context);
                              showDialog(
                              context: context,
                              builder: (context) {
                                return AboutDialogBox();
                              },
                            );
                            },
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: .bottomCenter,
                      child: FilledButton(
                        onPressed: () {
                          signedOut();
                        },
                        child: Text("Log Out"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(IconData leadingIcon, String title, VoidCallback onTap) {
    return Material(
      animateColor: true,
      // elevation: 3,
      shadowColor: AppColors.bg,
      color: Colors.transparent,
      child: ListTile(
        focusColor: AppColors.bg.withValues(alpha: 0.5),
        tileColor: AppColors.bg.withAlpha(150),
        iconColor: AppColors.textPrimary,
        textColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.textPrimary.withAlpha(100), // Border color
            width: 1.5, // Border width
          ),
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        leading: Icon(leadingIcon),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios_rounded),
        onTap: onTap,
      ),
    );
  }
}

  // Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 2.0),
  //                         child: FaIcon(FontAwesomeIcons.clock, color: AppColors.textSecondary,size: 17,),
  //                       ),
  //                       SizedBox(width: 10,),
  //                       Column(
  //                         children: [
  //                           Text("Opening hours Daily"),
  //                           Text("11AM - 11PM"),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                   Spacer(),
  //                   //signout button
  //                   Align(
  //                     alignment: .bottomCenter,
  //                     child: FilledButton(onPressed: () {
  //                       signedOut();
  //                     }, child: Text("Sign Out")),
  //                   )