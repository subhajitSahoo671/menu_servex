import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';
// import 'package:menu_servex/data/model/cart_items/cart_items.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';
// import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.cartItems});

  final CartItemsModel cartItems;

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
            height: MediaQuery.widthOf(context)*0.34,
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
                      child: Image(image: NetworkImage(cartItems.image),fit: .cover,)),
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
                              child: Text(cartItems.item,maxLines: 2, 
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: (screenWidth*0.04).clamp(16, 26),
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                  height: 1.2,
                                ),),
                            ),
                            SizedBox(width: 30,)
                          ],
                        ),
                    
                        SizedBox(height: (screenWidth*0.01).clamp(2, 6),),
                    
                        //size
                        Text(cartItems.variation,style:  TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: (screenWidth*0.03).clamp(14, 20),
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textSecondary,
                                  // height: 1.2,
                                ),),
                        SizedBox(height: (screenWidth*0.01).clamp(4, 12),),
                    
                       Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                           //price
                        Text("₹${cartItems.price.toStringAsFixed(2)}",style:  TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: (screenWidth*0.04).clamp(16, 24),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                  // height: 1.2,
                                ),),
                    
                           //itemCount
                          Row(
                            children: [
                              IconButton.filledTonal(
                                padding: .all((screenWidth*0.0001).clamp(6, 10)),
                                iconSize: (screenWidth*0.02).clamp(18, 25),
                                constraints: BoxConstraints(maxHeight: (screenWidth*0.06).clamp(30, 80),maxWidth: (screenWidth*0.06).clamp(30, 80)),
                                onPressed: () {
                                  // setState(() {
                                  //   if (itemCount > 1) {
                                  //     itemCount -= 1;
                                  //   }
                                  // });
                                },
                                icon: Icon(Icons.remove),
                              ),
                              SizedBox(width: (screenWidth*0.005).clamp(2, 6)),
                              Text(
                                "${cartItems.quantity}",
                                style: TextStyle(
                                  fontSize: (screenWidth*0.04).clamp(16, 26),
                                  fontWeight: .w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              SizedBox(width: (screenWidth*0.005).clamp(2, 6)),
                              IconButton.filled(
                                 padding: .all((screenWidth*0.0001).clamp(6, 10)),
                                iconSize: (screenWidth*0.02).clamp(18, 25),
                                constraints: BoxConstraints(maxHeight: (screenWidth*0.06).clamp(30, 80),maxWidth: (screenWidth*0.06).clamp(30, 80)),
                                onPressed: () {
                                  // setState(() {
                                  //   if (itemCount < 20) {
                                  //     itemCount += 1;
                                  //   }
                                  // });
                                },
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                       )
                    
                      ],
                    ),
                 Positioned(
                  top: 2,
                  right: 2,
                  child: SvgPicture.asset(cartItems.diet == "veg"? AppImages.vegIcon: AppImages.nonVegIcon,height: (screenWidth*0.04).clamp(18, 26),width: (screenWidth*0.04).clamp(18, 26),)
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