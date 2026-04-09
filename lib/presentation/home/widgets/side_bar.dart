import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/domain/entity/menu_categories/categories.dart';
import 'package:menu_servex/presentation/home/widgets/menu_items.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key, required this.categories});

  final List<CategoriesEntity> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                child: ListTile(leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.textPrimary,
                  child: SizedBox(
                    child: CloseButton(
                      color: AppColors.bg),
                  ),),),
              )
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                physics: BouncingScrollPhysics(),
                itemCount: categories.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 15);
                },
                itemBuilder: (BuildContext context, int index) {
                  log("pinku ${categories[index]}");
                  final name = categories[index].category as String? ?? 'Unknown';
                  final pic = categories[index].banner ;
                  return InkWell(
                    onTap: () {
                     
                    },
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image:  DecorationImage(image: NetworkImage(pic), fit: BoxFit.cover) ,
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          decoration: BoxDecoration(
                             color: AppColors.bg.withAlpha(200),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(name, style: TextStyle(color: AppColors.textSecondary, fontSize: 18, fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
  }
}