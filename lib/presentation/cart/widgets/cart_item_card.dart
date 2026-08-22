import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';
// import 'package:menu_servex/data/model/cart_items/cart_items.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';
import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';
// import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.cartItem, required this.removeCartItem, required this.addCartItem});

  final CartItemsModel cartItem;
  final VoidCallback removeCartItem;
  final VoidCallback addCartItem;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.widthOf(context);
    int totalAmount =
        cartItem.price * cartItem.quantity;
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
                  flex: 3,
                  child: Padding(
                  padding: const .symmetric(vertical: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20),
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Image(image: NetworkImage(cartItem.image),fit: .cover,)),
                    ),
                  ),
                ),
                SizedBox(width: (screenWidth*0.03).clamp(12, 25),),
              //details
              Expanded(
                flex: 6,
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
                              child: Text(cartItem.item,maxLines: 2, 
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
                    
                        SizedBox(height: (screenWidth*0.005).clamp(2, 6),),
                    
                        //size
                        Text(cartItem.variation,style:  TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: (screenWidth*0.03).clamp(14, 18),
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textSecondary,
                                  // height: 1.2,
                                ),),
                        SizedBox(height: (screenWidth*0.006).clamp(3, 12),),
                        // Spacer(),
                    
                       Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                           //price
                        Text("₹${totalAmount.toStringAsFixed(2)}",style:  TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: (screenWidth*0.04).clamp(16, 24),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                  // height: 1.2,
                                ),),
                    
                           //itemCount
                          Row(
                            children: [
                              InkWell(overlayColor: .all(Colors.transparent),
                              splashColor: Colors.transparent,
                                onTap: () {
                                  removeCartItem();
                                  // setState(() {
                                  //   if (itemCount > 1) {
                                  //     itemCount -= 1;
                                  //   }else{
                                  //    widget.removeCartItem();
                                    
                                  //   }
                                  // });
                                },
                                child: CircleAvatar(
                                 radius: (screenWidth*0.024).clamp(14, 22),
                                 child: Padding(
                                   padding: .all((screenWidth*0.006).clamp(5, 10)),
                                 child: Center(child: Icon(cartItem.quantity <= 1 ? Icons.delete : Icons.remove,size: (screenWidth*0.02).clamp(16, 22),)),
                                 ),
                                //  backgroundColor: AppColors.primary.withAlpha(230),
                                
                                ),
                              ),
                              SizedBox(width: (screenWidth*0.007).clamp(8,12)),
                              Text(
                                "${cartItem.quantity}",
                                style: TextStyle(
                                  fontSize: (screenWidth*0.04).clamp(16, 24),
                                  fontWeight: .w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              SizedBox(width: (screenWidth*0.007).clamp(8, 12)),
                             InkWell(overlayColor: .all(Colors.transparent),
                              splashColor: Colors.transparent,
                                onTap: () {
                                addCartItem();
                                  // setState(() {
                                  //   if (itemCount < 20) {
                                  //     itemCount += 1;
                                  //   }
                                  // });
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColors.primary.withAlpha(245),
                                  foregroundColor: AppColors.bg,
                                 radius: (screenWidth*0.024).clamp(14, 22),
                                 child: Padding(
                                   padding: .all((screenWidth*0.006).clamp(5, 10)),
                                 child: Center(child: Icon(Icons.add,size: (screenWidth*0.02).clamp(16,22),)),
                                 ),
                                //  backgroundColor: AppColors.primary.withAlpha(230),
                                
                                ),
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
                  child: SvgPicture.asset(cartItem.diet == "veg"? AppImages.vegIcon: AppImages.nonVegIcon,height: (screenWidth*0.04).clamp(18, 26),width: (screenWidth*0.04).clamp(18, 26),)
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