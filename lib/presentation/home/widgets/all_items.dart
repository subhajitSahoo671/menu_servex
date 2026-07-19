import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/domain/entity/menu_categories/categories.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';
import 'package:menu_servex/presentation/home/bloc/menuItems/menu_items_cubit.dart';
import 'package:menu_servex/presentation/home/bloc/menuItems/menu_items_state.dart';
import 'package:menu_servex/presentation/home/widgets/item_card.dart';

class AllItems extends StatefulWidget {
  final List<CategoriesEntity> categories;
  final ScrollController scrollController;


  const AllItems({super.key, required this.categories,required this.scrollController});

  @override
  State<AllItems> createState() => AllItemsState();
}

class AllItemsState extends State<AllItems> {
  List<GlobalKey> keys = [];


  BuildContext? tabContext;

  @override
  void initState() {
    keys = List.generate(widget.categories.length, (_) => GlobalKey());
    // scrollController = ScrollController();
    widget.scrollController.addListener(animateToTabs);
    super.initState();
  }

  //here we have to develop a function for
  //navigating betn tabs with some animation
  void animateToTabs() {
    late RenderBox box;

    if (tabContext == null || !widget.scrollController.hasClients) return;

    for (var i = 0; i < keys.length; i++) {
      final context = keys[i].currentContext;
      if (context == null) continue;

      box = context.findRenderObject() as RenderBox;
      final viewport = RenderAbstractViewport.of(box);
      final offset = viewport.getOffsetToReveal(box, 0).offset;

      // Offset position = box.localToGlobal(Offset.zero);
      //       if (scrollController.offset >= position.dy) {
      //         DefaultTabController.of(
      //           tabContext!,
      //         ).animateTo(i, duration: Duration(milliseconds: 100));}

      if (widget.scrollController.offset >= offset + 50) {
        final controller = DefaultTabController.of(tabContext!);
        if (controller.index != i) {
          controller.animateTo(i, duration: const Duration(milliseconds: 100));
        }
      }
    }
  }

  void scrollToIndex(int index) async {
    widget.scrollController.removeListener(animateToTabs);
    final catagories = keys[index].currentContext!;


    await Scrollable.ensureVisible(
      catagories,
      duration: Duration(milliseconds: 500),
    );
    animateToTabs();
    widget.scrollController.addListener(animateToTabs);
  }

  @override
  Widget build(BuildContext context) {
    // var index = 0;
    return Builder(
      builder: (context) {
        tabContext = context;
        return SingleChildScrollView(
          // controller: widget.scrollController,
          child: Column(
            children: [
              ...widget.categories.asMap().entries.map((entry) {
                int index = entry.key;
                var catg = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      key: keys[index],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16,),
                            Text(
                              catg.category,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 4,),
                            Text(
                              catg.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(height: 8,),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<MenuItemsCubit, MenuItemsState>(
                      builder: (context, state) {
                        if (state is MenuItemsLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.bg,
                            ),
                          );
                        }
                
                        if (state is MenuItemsLoaded) {
                
                          List<ItemsEntity> items = state.items[index];
                          return GridView.builder(
                            shrinkWrap: true,
                            // primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(10),
                            gridDelegate:
                                 SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  mainAxisExtent: 310,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 350/200
                                ),
                            // itemCount: items.length,
                            itemCount: 8,
                            itemBuilder: (BuildContext context, int i) {
                              return ItemCard(items: items[0]);
                            },
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
