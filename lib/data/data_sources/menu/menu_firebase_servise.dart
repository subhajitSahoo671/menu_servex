import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:menu_servex/data/model/menu_categories/categories.dart';
import 'package:menu_servex/data/model/menu_items/items.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:menu_servex/domain/entity/menu_categories/categories.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';

abstract class MenuFirebaseServise {
    Future<Either> getMenuCategories();
    Future<Either> getMenuItems();
}

class MenuFirebaseServiseImpl extends MenuFirebaseServise{
  @override
  Future<Either> getMenuCategories() async {
    try {
      List<CategoriesEntity> categories = [];

      var data = await FirebaseFirestore.instance.collection("Menu-catagories").get();
    // log("hy:${data.docs.length}");
    var docs = data.docs;
    // docs.sort();
      for(var doc in docs){
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
  Future<Either> getMenuItems() async {
    try {
      final categories = [
        "burger",
        "dessert",
        "pizza",
        "frenchFries",
        "pasta",
        "specialSalads",
        "coldDrinks",
      ]..sort();

      final futures = categories.map((docId) async {
        final data = await FirebaseFirestore.instance
            .collection("Menu-catagories")
            .doc(docId)
            .collection("items")
            .get();

        return data.docs
            .map((docSnap) => ItemsModel.fromJson(docSnap.data()).toEntity())
            .toList();
      }).toList();

      final listOfItems = await Future.wait(futures);
      return right(listOfItems);
    } on FirebaseException catch (e) {
      log("error:$e");
      return left(e.message);
    }
  }

}