import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:menu_servex/data/model/updateStatus/update_status.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:menu_servex/data/model/orderDetails/order_details.dart';
// import 'package:random_string/random_string.dart';

abstract class CookOrdersFirebaseServise {
  // Future<Either> confirmOrderDetails(OrderDetailsModel orderDetails);
  Future<Either> getOrders();
  Future<Either> updateStatus(UpdateStatusModel status);
}

class CookOrdersFirebaseServiseImpl extends CookOrdersFirebaseServise {
  @override
  Future<Either> getOrders() async{
   try {

     return right(FirebaseFirestore.instance.collection("orders").orderBy("orderTime",descending: true).snapshots()) ;
     
   } on FirebaseException catch (e) {
     print("error$e");
     return  left(e.message);
   }
  }

  @override
  Future<Either> updateStatus(UpdateStatusModel cradentials) async{
   try {

      await Future.wait([
          // update user order status in user order collection
          FirebaseFirestore.instance
              .collection("Users")
              .doc(cradentials.userId)
              .collection("orders")
              .doc(cradentials.orderId)
              .update({
                "orderStatus": cradentials.status,
              }),

          // update global user order status in order collection
          FirebaseFirestore.instance.collection("orders").doc(cradentials.orderId).update({
            "orderStatus": cradentials.status,
          }),
        ]);

      return right("Status Updated") ;
   } on FirebaseException catch (e) {
     print("error$e");
     return left(e.message);
   }
  }

}
