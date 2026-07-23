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
      List<List<ItemsEntity>> listOfItems = [];
  //         // 3. Initialize a WriteBatch
  // final WriteBatch batch = FirebaseFirestore.instance.batch();


      // List olddocs = ["7yUUhJQnzgjgMi8qFfNx","DR7goCxwRHisSAeriDHx","LA4eqIdlXgkUNdkrRmw1","UwheYfjiz7f5As9QSvFB","jbtWJj6RKcOhn116Ucqt","veKzso0jU4kBhaucknRi","xit6MJKuXtm9MbUvL99b"];
      // List collection = ["burger","dessert","pizza","french fries","pasta","special salads","coldDrinks"];
      List newDocs = ["burger","dessert","pizza","frenchFries","pasta","specialSalads","coldDrinks"];
      newDocs.sort();

      // Use an index-based loop so we fetch the matching collection for each doc
      for (int idx = 0; idx < newDocs.length; idx++) {
        final docId = newDocs[idx];
        // final colName = collection[idx];

        var data = await FirebaseFirestore.instance.collection("Menu-catagories").doc(docId).collection("items").get();

        // var destRef =  FirebaseFirestore.instance.collection("Menu-catagories").doc(newDocs[idx]).collection("items");

        List<ItemsEntity> items = []; // reset per-collection

        for (var docSnap in data.docs) {
  // // 4. Loop through documents and stage them in the batch
  //           Map<String, dynamic> data = docSnap.data(); 
    // // Set data into destination collection using the same document ID
    // batch.set(destRef.doc(docId), data);

          log("data:${docSnap.data()}");
          var itemsModel = ItemsModel.fromJson(docSnap.data());
          items.add(itemsModel.toEntity());
        }

        listOfItems.add(items);
      }

    //  for (var doc in olddocs){
    //    var data = await FirebaseFirestore.instance.collection("Menu").doc(doc).collection(collectionPath)
    // log("hy:${data.docs}");
    //   for(var doc in data.docs){
    //     // log("data:${doc.data()}");
    //     var itemsModel = ItemsModel.fromJson(doc.data());
    //     items.add(itemsModel.toEntity());
    //   }
    //  }

  //    // 5. Commit all writes to Firestore simultaneously
  // await batch.commit();

    // log("listotitems:$listOfItems");
    
      
      return right(listOfItems);


    } on FirebaseException catch (e) {
      log("error:$e");
      return left(e.message);
    }
  }

}