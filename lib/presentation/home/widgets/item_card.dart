import 'package:flutter/material.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/domain/entity/menu_categories/categories.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.items});

  final ItemsEntity items;

  @override
  Widget build(BuildContext context) {
    // print("gygggygyg$catg");
    return SizedBox(
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
                width: 200,
                height: 170,
              ),
            ),
            Container(
              height: 130,
              padding: const EdgeInsets.all( 10.0),
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    items.diet,
                    maxLines: 2,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 5,),
                    ],
                  ),
                  Text(
                    items.description,
                    maxLines: 2,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                   SizedBox(height: 5,),
                  // Spacer(),
                 Text.rich(
                  TextSpan(
                    text:  "₹${items.price[0]}",
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: items.price.length >= 2 ? " - ₹${items.price[items.price.length-1]}": " ",
                      )
                    ]
                  )
                 )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 