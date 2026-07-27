import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';
import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';
import 'package:menu_servex/presentation/cart/pages/cart_page.dart';
import 'package:menu_servex/presentation/home/widgets/about_dialog_box.dart';
// import 'package:menu_servex/presentation/home/widgets/side_bar.dart';


class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({super.key, this.tabBar, required this.cartItems});

  final List<CartItemsModel> cartItems;

  final  Widget? tabBar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: AppBar(
        animateColor: false,
        foregroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(kToolbarHeight),
        //   child: Container(
        //     margin: const EdgeInsets.only(bottom: 10.0),
        //     child: Row(
        //       children: [
        //          InkWell(
        //            onTap: () {
        //             Scaffold.of(context).openDrawer();
        //           },
        //           child: Icon(Icons.menu, size: 28),
        //          ),
        //          SizedBox(width: 8,),
        //         Expanded(child: tabBar!),
        //       ],
        //     ),
        //   ),
        // ),
        leading: Hero(
          tag: 1,
          child: Image.asset(AppImages.logo, height: 80, width: 80),
        ),
        actions: [
          Container(
            margin: .symmetric(horizontal: 2,vertical: 8),
            child: IconButton.filled(
              onPressed: () {},
              icon: Icon(Icons.search_rounded),
              color: Colors.white,
            ),
          ),
          // SizedBox(width: 10,),
               Stack(
                 children: [
                   Container(
                               margin: .symmetric(horizontal: 4,vertical: 8),
                     child: IconButton.filled(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));
                      },
                      icon: FaIcon(FontAwesomeIcons.cartShopping),
                      color: Colors.white,
                      iconSize: 16,
                                   ),
                   ),
                  if(cartItems.isNotEmpty) Positioned(
                    right: 0,
                    top: 4,
                     child: CircleAvatar(
                      // backgroundColor: AppColors.textPrimary,
                      foregroundColor: AppColors.primary,
                      radius: 10,
                      child: Text("${cartItems.length}",style: TextStyle(fontSize: 12,fontWeight: .w700),),
                     ),
                   )
                 ],
               ),
            
          // SizedBox(width: 10,),
          Container(
            margin: .symmetric(horizontal: 2,vertical: 8),
            child: IconButton.filled(
              onPressed: () {
                showDialog( context: context,
                 builder: (context) {
                   return AboutDialogBox();
                 },
                );
              },
              icon: Icon(Icons.info_outline_rounded),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
