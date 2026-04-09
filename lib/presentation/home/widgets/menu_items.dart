import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:menu_servex/domain/entity/menu_categories/categories.dart';

class MenuItems extends StatefulWidget {
  final List<CategoriesEntity> categories;

  const MenuItems({super.key, required this.categories,});

  @override
  State<MenuItems> createState() => MenuItemsState();
}

class MenuItemsState extends State<MenuItems> {

  List<GlobalKey> keys = [];

  late ScrollController scrollController;

  BuildContext? tabContext;

  @override
  void initState() {
    keys = List.generate(widget.categories.length, (_) => GlobalKey());
    scrollController = ScrollController();
    scrollController.addListener(animateToTabs);
    super.initState();
  }

  //here we have to develop a function for
  //navigating betn tabs with some animation
  void animateToTabs() {
    late RenderBox box;

    if (tabContext == null) return;

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
    
    if (scrollController.offset >= offset - 100) {
      DefaultTabController.of(tabContext!)
          .animateTo(i, duration: Duration(milliseconds: 100));
      }
    }
  }

  void scrollToIndex(int index) async{
    scrollController.removeListener(animateToTabs);
      final catagories = keys[index].currentContext!;

      await Scrollable.ensureVisible(catagories,
      duration: Duration(milliseconds: 500)
      );

      scrollController.addListener(animateToTabs);
  }

  @override
  Widget build(BuildContext context) {
    // var index = 0;
    return Builder(
      builder: (context) {
        tabContext = context;
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              ...widget.categories.asMap().entries.map((entry) {

                int index = entry.key;
                var catg = entry.value;

                return Column(
                  children: [
                    SizedBox(
                      key: keys[index],
                      child: Text(catg.category),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        // primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              mainAxisExtent: 250,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            child: Card(
                              color: Colors.white,
                              // margin: EdgeInsets.all(10),
                              elevation: 2,
                              shadowColor: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: NetworkImage(catg.banner),
                                      fit: BoxFit.cover,
                                      width: 200,
                                      height: 150,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          catg.category,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          catg.description,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
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
