import 'package:dartz/dartz.dart';
import 'package:menu_servex/data/model/orderDetails/order_details.dart';

abstract class OrdersRepository {
  Future<Either> confirmOrderDetails( OrderDetailsModel orderDetails);
  Future<Either> getUserOrders();
  // Future<String?> getAccessToken();
}