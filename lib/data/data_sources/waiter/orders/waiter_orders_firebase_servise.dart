import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:menu_servex/data/model/updateStatus/update_status.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:menu_servex/data/model/orderDetails/order_details.dart';
// import 'package:random_string/random_string.dart';

abstract class WaiterOrdersFirebaseServise {
  // Future<Either> confirmOrderDetails(OrderDetailsModel orderDetails);
  Future<Either> getOrders();
  Future<Either> updateStatus(UpdateStatusModel status);
}

class WaiterOrdersFirebaseServiseImpl extends WaiterOrdersFirebaseServise {
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

  // @override
  // Future<Either> confirmOrderDetails(OrderDetailsModel orderDetails) async {
  //   try {
  //     var user = FirebaseAuth.instance.currentUser;

  //     String orderId = randomAlphaNumeric(10);

  //     if (user != null) {
  //       final orderData = orderDetails.toJson()
  //         ..['orderId'] = orderId
  //         // ..['orderStatus'] = 'Pending'
  //         ..['userId'] = orderDetails.userId ?? user.uid;

  //       await Future.wait([
  //         // add user order details in user order collection
  //         FirebaseFirestore.instance
  //             .collection("Users")
  //             .doc(user.uid)
  //             .collection("orders")
  //             .doc(orderId)
  //             .set(orderData),

  //         // add global user order details in order collection
  //         FirebaseFirestore.instance.collection("orders").doc(orderId).set(orderData),
  //       ]);
  //     } else {
  //       print("user Not Found");
  //     }

  //     print("Order Successful");

  //     return Right("Order Successful");
  //   } on FirebaseException catch (e) {
  //     print("error:$e");
  //     return left(e.message);
  //   }
  // }
}
