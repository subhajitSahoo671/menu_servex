import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/presentation/cart/pages/cart_page.dart';
import 'package:menu_servex/presentation/home/widgets/about_dialog_box.dart';
// import 'package:menu_servex/presentation/home/widgets/side_bar.dart';


class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({super.key, this.tabBar});

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
          IconButton.filled(
            onPressed: () {},
            icon: Icon(Icons.search_rounded),
            color: Colors.white,
          ),
          SizedBox(width: 5,),
          IconButton.filled(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));
            },
            icon: FaIcon(FontAwesomeIcons.cartShopping),
            color: Colors.white,
            iconSize: 18,
          ),
          SizedBox(width: 5,),
          IconButton.filled(
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
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
