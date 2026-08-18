import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_servex/core/configs/constants.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/data/model/menu_items/items.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';
import 'package:menu_servex/presentation/favorite/bloc/favorite_items_cubit.dart';
import 'package:menu_servex/presentation/favorite/widgets/favorite_item_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.widthOf(context);
    final String displayTableNum = TableNum.tableNum;
    return Scaffold(
       appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          overlayColor: .all(Colors.transparent),
          splashColor: Colors.transparent,
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text("Favorites"),
        actions: [
         if(displayTableNum != "No Table") ElevatedButton.icon(
            onPressed: () {},
            label: Text(displayTableNum, style: TextStyle(fontSize: 16)),
            icon: Icon(Icons.table_bar, size: 20),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: (screenWidth * 0.04).clamp(12, 90),
          left: (screenWidth * 0.04).clamp(12, 90),
          // top: (screenWidth * 0.04).clamp(12, 30),
        ),
        child: BlocBuilder<FavoriteItemsCubit, List<ItemsEntity>>(
          builder: (context, favItems) {
            return  favItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 100,
                          color: AppColors.textPrimary,
                        ),
                        SizedBox(height: 32),
                        Text(
                          "Your Wish List is empty!",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 16),
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("View Menu"),
                        ),
                      ],
                    ),
                  ) 
                  : SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: .center,
                                    mainAxisAlignment: .start,
                                    children: [
                  SizedBox(height: (screenWidth * 0.03).clamp(8, 30)),
                 Container(
                  
            alignment: AlignmentGeometry.topCenter,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 650,
                // maxHeight: 200
              ),
              child: ListView.separated(
                itemCount: favItems.length,
                shrinkWrap: true,
                physics:  NeverScrollableScrollPhysics(),
                   
                separatorBuilder: (BuildContext context, int index) {
                  return Container(height: 8);
                },
                itemBuilder: (BuildContext context, int index) {
                  return FavoriteItemCard(
                    favItem: favItems[index],
                    
                  );
                },
              ),
            ),
                  
                 )
                                    ]
                                  ),
                                );
          }
        )
                          
      ),
    );
  }
}