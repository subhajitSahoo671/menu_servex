// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
// import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
// import 'package:menu_servex/domain/entity/menu_categories/categories.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';
import 'package:menu_servex/presentation/home/widgets/add_to_cart_modal.dart';
import 'package:svg_flutter/svg_flutter.dart';
// import 'package:svg_flutter/svg.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.items});

  final ItemsEntity items;

   void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bg,
      barrierColor: Colors.black.withAlpha(200),
      barrierLabel: "Add To Cart",
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      anchorPoint: Offset(100, 100),
      useSafeArea: true,
      elevation: 20,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.heightOf(context) * 0.85,
        maxWidth: 400,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return  Addtocartmodal(item:items); },
    );
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.widthOf(context);
    // print("gygggygyg$catg");
    return SizedBox(
      child: InkWell(overlayColor: .all(Colors.transparent),
                              splashColor: Colors.transparent,
        onTap: () {
          _showBottomSheet(context);
        },
        child: Card(
          color: Colors.white,
          // margin: EdgeInsets.all(10),
          elevation: 2,
          shadowColor: Colors.white,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: NetworkImage(items.image),
                  fit: BoxFit.cover,
                  width: (screenWidth*0.2).clamp(190, 210),
                  height: (screenWidth*0.14).clamp(120, 190),
                ),
              ),
              Container(
                // height: 130,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          items.item,
                          maxLines: 1,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: (screenWidth*0.04).clamp(17, 18),
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(items.diet =="veg"? AppImages.vegIcon:AppImages.nonVegIcon,height: (screenWidth*0.03).clamp(14, 16),width: (screenWidth*0.03).clamp(14, 15),),
                            SizedBox(width: 4,),
                            Text(
                              items.diet,
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: (screenWidth*0.03).clamp(15, 16),
                                fontWeight: FontWeight.w400,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                      ],
                    ),
                    Text(
                      items.description,
                      maxLines: 2,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: (screenWidth*0.03).clamp(16, 17),
                        color: AppColors.textSecondary,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 7),
                    // Spacer(),
                    Text.rich(
                      TextSpan(
                        text: "₹${items.sortedVariations.values.elementAt(0)}",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: (screenWidth*0.02).clamp(17, 18),
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: items.sortedVariations.values.length >= 2
                                ? " - ₹${items.sortedVariations.values.elementAt(items.sortedVariations.values.length - 1)}"
                                : " ",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
