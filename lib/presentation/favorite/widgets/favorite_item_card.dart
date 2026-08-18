import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';
import 'package:menu_servex/data/model/menu_items/items.dart';
// import 'package:menu_servex/data/model/cart_items/cart_items.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';
import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';
import 'package:menu_servex/presentation/favorite/bloc/favorite_items_cubit.dart';
// import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';
import 'package:svg_flutter/svg_flutter.dart';

class FavoriteItemCard extends StatelessWidget {
  const FavoriteItemCard({super.key,
   required this.favItem,  
   });

  final ItemsEntity favItem;
  // final VoidCallback removeItem;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.widthOf(context);
    
    return Card(
      color: Colors.white,
          elevation: 2,
          shadowColor: Colors.white,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 650,
              maxHeight: 200
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            width: MediaQuery.widthOf(context),
            height: MediaQuery.widthOf(context)*0.33,
            padding: .all((screenWidth*0.02).clamp(10, 20)),
            child: Row(
             children: [
               //image
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(20),
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Image(image: NetworkImage(favItem.image),fit: .cover,)),
                  ),
                ),
                SizedBox(width: (screenWidth*0.03).clamp(12, 25),),
              //details
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      mainAxisAlignment: .center,
                      children: [
                        //title
                        Row(
                          children: [
                            Expanded(
                              child: Text(favItem.item,maxLines: 2, 
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: (screenWidth*0.04).clamp(16, 24),
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                  height: 1.2,
                                ),),
                            ),
                            SizedBox(width: 30,)
                          ],
                        ),
                    
                       ...[ SizedBox(height: (screenWidth*0.005).clamp(2, 6),),
                    
                        //diet
                        Text(favItem.diet,style:  TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: (screenWidth*0.03).clamp(14, 18),
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textSecondary,
                                  // height: 1.2,
                                ),),],
                                
                        
                      ...[  
                        // SizedBox(height: (screenWidth*0.001).clamp(2, 12),),
                    
                       Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                           //price
                       
                                 Text.rich(
                      TextSpan(
                        text: "₹${favItem.sortedVariations.values.elementAt(0)}",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: (screenWidth*0.04).clamp(16, 24),
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: favItem.sortedVariations.values.length >= 2
                                ? " - ₹${favItem.sortedVariations.values.elementAt(favItem.sortedVariations.values.length - 1)}"
                                : " ",
                          ),
                        ],
                      ),
                    ),
                    
                           //favorite
                         IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            context.read<FavoriteItemsCubit>().removeFavoriteItem(favItem );
                                 
                         }, icon: Icon(Icons.favorite,color: AppColors.primary,))
                        ],
                       )]
                    
                      ],
                    ),
                 Positioned(
                  top: 2,
                  right: 2,
                  child: SvgPicture.asset(
                    favItem.diet == "veg"? 
                    AppImages.vegIcon
                    : AppImages.nonVegIcon,
                    height: (screenWidth*0.04).clamp(18, 26),width: (screenWidth*0.04).clamp(18, 26),)
                  )
                  ],
                ),
              )
             ],
            ),
          ),
    );
  }
}