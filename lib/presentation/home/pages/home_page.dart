import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/domain/entity/menu_categories/categories.dart';
import 'package:menu_servex/presentation/home/bloc/menu_categories_cubit.dart';
import 'package:menu_servex/presentation/home/bloc/menu_categories_state.dart';
// import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/presentation/home/widgets/basic_app_bar.dart';
import 'package:menu_servex/presentation/home/widgets/menu_items.dart';
import 'package:menu_servex/presentation/home/widgets/side_bar.dart';
// import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<MenuItemsState> _childKey = GlobalKey<MenuItemsState>();

  //  final List<GlobalKey> keys = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuCategoriesCubit()..getMenuCategories(),
      child: BlocBuilder<MenuCategoriesCubit, MenuCategoriesState>(
        builder: (context, state) {
          if (state is MenuCategoriesLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.bg),
            );
          }

          if (state is MenuCategoriesLoaded) {

          //  for (var i = 0; i < state.categories.length; i++) {
          //    keys.add(GlobalKey());
          //  }
           
            return DefaultTabController(
              length: state.categories.length,
              child: Scaffold(
                drawerScrimColor: AppColors.bg.withAlpha(200),
                drawer: Drawer(
                  backgroundColor: AppColors.bg,
                  clipBehavior: Clip.antiAlias,
                  elevation: 20,
                  shadowColor: AppColors.textPrimary,
                  child: SideBar(categories: state.categories),
                ),
                appBar: BasicAppBar(tabBar: _tabBar(state.categories)),
                body:  MenuItems(categories: state.categories, key: _childKey),
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _tabBar(List<CategoriesEntity> state) {
    return TabBar(
      isScrollable: true,
      physics: BouncingScrollPhysics(),
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      splashBorderRadius: BorderRadius.circular(30),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      
      labelColor: AppColors.bg,
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.textPrimary,
      ),
      tabAlignment: TabAlignment.start,
      tabs: [for (final title in state) Tab(child: Text(title.category))],
      onTap: (int index) {
        final state = _childKey.currentState;
  if (state != null) {
    state.scrollToIndex(index);
  }
      },
    );
  }
}

 

    // ScrollableListTabScroller.defaultComponents(
    //     animationDuration: Duration(milliseconds: 300),
    //     padding: EdgeInsets.all(  16),
    //     shrinkWrap:  true,
    //     tabBarProps:  TabBarProps(
    //       isScrollable: true,
    //       physics: BouncingScrollPhysics(),
    //       dividerColor: Colors.transparent,
    //         indicatorSize: TabBarIndicatorSize.tab,
    //         labelColor: AppColors.bg,
    //         labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //       indicator: BoxDecoration(
    //         borderRadius: BorderRadius.circular(30),
    //         color: AppColors.textPrimary,
    //       ),
    //       tabAlignment: TabAlignment.start,
    //     ),
    //     itemCount: _tabTitles.length,
    //     tabBuilder: (context, index, active) => 
    //     SizedBox(
    //       width: 200,
    //       child: Row(
    //         children: [
    //           IconButton(
    //               onPressed: () {
    //                 Scaffold.of(context).openDrawer();
    //               },
    //               icon: Icon(Icons.menu),
    //             ),
    //           Expanded(
    //             child: Tab(
    //                       // height: kToolbarHeight*2,        
    //                       child: Container(
    //             // height: kToolbarHeight * 1.5,
    //             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(30),
    //               color: active ? AppColors.textPrimary : null,
    //             ),
    //             child: Center(
    //               child: Text(
    //                 _tabTitles[index]['name'],
    //                 style: TextStyle(
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.bold,
    //                   color: active ? AppColors.bg : AppColors.textPrimary.withAlpha(200),
    //                 ),
    //               ),
    //             ),
    //                       ),
    //                     ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     itemBuilder:(context, index) => Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Image.network(_tabTitles[index]['pic'], height: 200, fit: BoxFit.cover),
    //           SizedBox(height: 16),
    //           Padding(
    //             padding: EdgeInsets.symmetric(horizontal: 16),
    //             child: Text(
    //               _tabTitles[index]['name'],
    //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //           SizedBox(height: 8),
    //           ...(_tabTitles[index]['Category'] as List<String>? ?? []).map((item) => ListTile(
    //                 title: Text(item),
    //                 leading: Icon(Icons.fastfood, color: AppColors.textPrimary),
    //               )),
    //           SizedBox(height: 20), // Add spacing between sections
    //         ],
    //       ),
    //     )
    //   ),