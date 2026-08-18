import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:menu_servex/data/model/orderDetails/order_details.dart';
import 'package:random_string/random_string.dart';

abstract class OrdersFirebaseServise {
  Future<Either> confirmOrderDetails(OrderDetailsModel orderDetails);
  Future<Either> getUserOrders();
}

class OrdersFirebaseServiseImpl extends OrdersFirebaseServise {
  @override
  Future<Either> getUserOrders() async{
   try {
      var user = FirebaseAuth.instance.currentUser;

     if (user != null) {
     return right(FirebaseFirestore.instance.collection("Users").doc(user.uid).collection("orders").orderBy("orderTime",descending: true).snapshots()) ;
     }
     else{
     return  left("user Not found");
     }
   } on FirebaseException catch (e) {
     print("error$e");
     return  left(e.message);
   }
  }

  @override
  Future<Either> confirmOrderDetails(OrderDetailsModel orderDetails) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      String orderId = randomAlphaNumeric(10);

      if (user != null) {

        if (orderDetails.tableNum != "No Table" || orderDetails.tableNum != null) {
          final orderData = orderDetails.toJson()
          ..['orderId'] = orderId
          // ..['orderStatus'] = 'Pending'
          ..['userId'] = orderDetails.userId ?? user.uid;

        await Future.wait([
          // add user order details in user order collection
          FirebaseFirestore.instance
              .collection("Users")
              .doc(user.uid)
              .collection("orders")
              .doc(orderId)
              .set(orderData),

          // add global user order details in order collection
          FirebaseFirestore.instance.collection("orders").doc(orderId).set(orderData),
        ]);
        }else{
          print("table number Not Found");
          return left("Table Number required");
        }

      } else {
        print("user Not Found");
      }

      print("Order Successful");

      return Right("Order Successful");
    } on FirebaseException catch (e) {
      print("error:$e");
      return left(e.message);
    }
  }
}
