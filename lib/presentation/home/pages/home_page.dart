import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/constants.dart';
// import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';
import 'package:menu_servex/domain/entity/menu_categories/categories.dart';
import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';
import 'package:menu_servex/presentation/home/bloc/menuCategory/menu_categories_cubit.dart';
import 'package:menu_servex/presentation/home/bloc/menuCategory/menu_categories_state.dart';
import 'package:menu_servex/presentation/home/bloc/menuItems/menu_items_cubit.dart';
// import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/presentation/home/widgets/basic_app_bar.dart';
import 'package:menu_servex/presentation/home/widgets/all_items.dart';
import 'package:menu_servex/presentation/home/widgets/side_bar.dart';
// import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key,  this.tableNum});

  final String? tableNum;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<AllItemsState> _childKey = GlobalKey<AllItemsState>();

  //  final List<GlobalKey> keys = [];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    TableNum.tableNum=widget.tableNum as String;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.widthOf(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<MenuCategoriesCubit>(
          create: (context) => MenuCategoriesCubit()..getMenuCategories(),
        ),
        BlocProvider<MenuItemsCubit>(create: (context) => MenuItemsCubit()..getMenuItems()),
      ],
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
                floatingActionButton: Row(
                  mainAxisAlignment: .end,
                  mainAxisSize: .min,
                  children: [
//                   widget.tableNum != null ? FloatingActionButton(
//                     heroTag: "tableNumber",
//                     tooltip: "Table Number",
//                   backgroundColor:  AppColors.bg.withAlpha(250),
//                   shape: CircleBorder(),
//                   elevation: 0,
//                   onPressed: () {
                  
//                 },
//                 child: ClipRRect(
//  borderRadius: BorderRadiusGeometry.circular(9999),
//                   child: Center(
//                     child: Text("${widget.tableNum}",style: TextStyle(fontSize: 16,fontWeight: .w600),),
//                         ),
//                 ),): Container(),
//                 SizedBox(width: 15,),
                FloatingActionButton(
                  heroTag: "orders",
                  tooltip: "Orders",
                   backgroundColor:  AppColors.bg.withAlpha(250),
                  shape: CircleBorder(),
                  elevation: 0,
                  onPressed: () {
                  
                },
                child: ClipRRect(
 borderRadius: BorderRadiusGeometry.circular(9999),
                  child: Center(
                    child: Icon(Icons.shopping_bag,size: 26,),
                        ),
                ),)
                ],),
                // backgroundColor: Colors.white,
                drawerScrimColor: AppColors.bg.withAlpha(200),
                drawer: Drawer(
                  backgroundColor: AppColors.bg,
                  clipBehavior: Clip.antiAlias,
                  elevation: 20,
                  shadowColor: AppColors.textPrimary,
                  child: SideBar(
                    categories: state.categories,
                    onCatagoryTap: (int index) {
                      final menuState = _childKey.currentState;
                      if (menuState != null) {
                        menuState.scrollToIndex(index);
                      }
                    },
                  ),
                ),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: BlocBuilder<CartItemsCubit,List<CartItemsModel>>(
                    builder: (context,cartItemsList) {
                      return BasicAppBar(cartItems:cartItemsList);
                    }
                  ),
                ),
                body: CustomScrollView(
                  controller: scrollController,
                  slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: (screenWidth*0.7).clamp(240, 450),
                      
                      automaticallyImplyLeading: false,
                      floating: false,
                      pinned: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: LayoutBuilder(
                          builder: (context, constraints) => 
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: constraints.maxWidth > 756 ? 12:0,vertical: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(constraints.maxWidth > 756 ?20:0),
                              child: Container(
                             decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(AppImages.homewWelcomeImg,),fit: .cover)
                             ),
                                child: BackdropFilter(
                                  filter: .blur(sigmaX: 25,sigmaY: 25),
                                  child: Center(
                                    child: Container(
                                      
                                      constraints: BoxConstraints(maxWidth: 750), 
                                      child: Image.asset(AppImages.homewWelcomeImg,fit: .cover,)),
                                  ),
                                ),
                              )),
                          ),
                        ),
                      ),
                    ),
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      automaticallyImplyLeading: false,
                      toolbarHeight: kToolbarHeight+15,
                      pinned: true,
                      flexibleSpace: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: Builder(
                          builder: (context) => Row(
                            crossAxisAlignment: .center,
                            mainAxisAlignment: .center,
                            children: [
                              InkWell(
                                overlayColor: .all(Colors.transparent),
                              splashColor: Colors.transparent,
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Icon(Icons.menu, size: 28),
                              ),
                              SizedBox(width: 10),
                              Expanded(child: _tabBar(state.categories)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: AllItems(categories: state.categories, key: _childKey, scrollController:scrollController)
                    ,)
                  ],
                ),
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  // AllItems(categories: state.categories, key: _childKey),

  // SliverAppBar(
  //                   expandedHeight: 300.0,
  //                   automaticallyImplyLeading: false,
  //                   floating: false,
  //                   pinned: false,
  //                   flexibleSpace: FlexibleSpaceBar(
  //                     background: Image.asset(AppImages.homewWelcomeImg),
  //                   ),
  //                 )

  Widget _tabBar(List<CategoriesEntity> state) {
    double screenWidth = MediaQuery.widthOf(context);

    return TabBar(
      isScrollable: true,
      physics: BouncingScrollPhysics(),
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      splashBorderRadius: BorderRadius.circular(30),
      overlayColor: WidgetStateProperty.all(Colors.transparent),

      labelColor: AppColors.bg,
      labelStyle: TextStyle(fontSize: (screenWidth*0.03).clamp(16, 20), fontWeight: FontWeight.bold),
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

