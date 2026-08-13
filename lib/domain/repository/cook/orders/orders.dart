import 'package:dartz/dartz.dart';
import 'package:menu_servex/data/model/updateStatus/update_status.dart';
// import 'package:menu_servex/data/model/orderDetails/order_details.dart';

abstract class CookOrdersRepository {
  // Future<Either> confirmOrderDetails( OrderDetailsModel orderDetails);
  Future<Either> getOrders();
  // Future<String?> getAccessToken();
  Future<Either> updateStatus(UpdateStatusModel cradentials);
}