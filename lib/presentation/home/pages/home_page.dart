
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
                  child: SideBar(categories: state.categories,
                   onCatagoryTap: (int index){
                    final menuState = _childKey.currentState;
                    if (menuState != null) {
                      menuState.scrollToIndex(index);
                    }
                  }),
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

