import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';

class OrderDetailsEntity {
  String? orderId;
  String? userId;
  String? tableNum;
  String? userName;
  String? orderStatus;
  Timestamp? orderTime;
  String? orderTotal;
  String? orderPaymentMethod;
  List? orderItems;

  OrderDetailsEntity({
    this.orderId,
    this.userId,
    required this.tableNum,
   required this.userName,
    this.orderStatus,
    this.orderTime,
   required this.orderTotal,
   required this.orderPaymentMethod,
   required this.orderItems,
  });
}