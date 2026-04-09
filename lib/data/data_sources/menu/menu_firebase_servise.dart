import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:menu_servex/data/model/menu_categories/categories.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:menu_servex/domain/entity/menu_categories/categories.dart';

abstract class MenuFirebaseServise {
    Future<Either> getMenuCategories();
    Future<Either> getMenuItems();
}

class MenuFirebaseServiseImpl extends MenuFirebaseServise{
  @override
  Future<Either> getMenuCategories() async {
    try {
      List<CategoriesEntity> categories = [];

      var data = await FirebaseFirestore.instance.collection("Menu").orderBy("timestamp").get();
    // log("hy:${data.docs.length}");
      for(var doc in data.docs){
        // log("data:${doc.data()}");
        var categoriesModel = CategoriesModel.fromJson(doc.data());
        categories.add(categoriesModel.toEntity());
      }
      //  log("message1:$categories");
      // if (categories.isEmpty) {
      //   // Add mock data for testing
      //   categories.add(CategoriesEntity(
      //     category: "Pasta",
      //     banner: "https://example.com/pasta.jpg",
      //     description: "Delicious pasta dishes",
      //   ));
      //   categories.add(CategoriesEntity(
      //     category: "Pizza",
      //     banner: "https://example.com/pizza.jpg",
      //     description: "Tasty pizzas",
      //   ));
      //   categories.add(CategoriesEntity(
      //     category: "Drinks",
      //     banner: "https://example.com/drinks.jpg",
      //     description: "Refreshing beverages",
      //   ));
      // }
      // log("message2:$categories");
      return right(categories);


    } on FirebaseException catch (e) {
      log("error:$e");
      return left(e.message);
    }
  }

  @override
  Future<Either> getMenuItems() {
    // TODO: implement getMenuItems
    throw UnimplementedError();
  }

}