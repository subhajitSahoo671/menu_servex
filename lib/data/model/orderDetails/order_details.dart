// import 'package:menu_servex/data/model/orderDetails/order_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';
import 'package:menu_servex/domain/entity/orders/order_details.dart';

class OrderDetailsModel {
  String? tableNum;
  String? orderId;
  String? userId;
  String? userName;
  String? orderStatus;
  Timestamp? orderTime;
  String? orderTotal;
  String? orderPaymentMethod;
  List? orderItems;

  OrderDetailsModel({
   required this.tableNum,
    this.orderId,
    this.userId,
    required this.userName,
    this.orderStatus,
    this.orderTime,
    required this.orderTotal,
    required this.orderPaymentMethod,
    required this.orderItems,
  });

  OrderDetailsModel.fromJson(Map<String, dynamic> data) {
    tableNum = data["tableNum"];
    orderId = data["orderId"];
    userId = data["userId"];
    userName = data["userName"];
    orderStatus = data["orderStatus"];
    orderTime = data["orderTime"];
    orderTotal = data["orderTotal"];
    orderPaymentMethod = data["orderPaymentMethod"];
    orderItems = data["orderItems"];
  }

  Map<String, dynamic> toJson() {
    return {
      if (orderId != null) 'orderId': orderId,
      'userId': userId,
      'userName': userName,
      'tableNum': tableNum,
      'orderStatus': 'Pending',
      'orderTime': DateTime.now(),
      'orderTotal': orderTotal,
      'orderPaymentMethod': orderPaymentMethod,
      'orderItems': orderItems?.map((item) => item.toJson()).toList(),
    };
  }
}

extension OrderDetailsModelX on OrderDetailsModel {
  OrderDetailsEntity toEntity() {
    return OrderDetailsEntity(
      orderItems: orderItems,
      orderPaymentMethod: orderPaymentMethod,
      orderTotal: orderTotal,
      userName: userName,
      tableNum: tableNum,
      orderId: orderId,
      orderStatus: orderStatus,
      orderTime: orderTime,
      userId: userId,
    );
  }
}
