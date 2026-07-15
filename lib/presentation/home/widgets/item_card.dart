import 'package:flutter/material.dart';
import 'package:menu_servex/domain/entity/menu_categories/categories.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key , required this.catg});

  final CategoriesEntity catg;

  @override
  Widget build(BuildContext context) {
    return  Card(
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
                                    height: 130,
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
                                        maxLines: 3,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                  
  }
}