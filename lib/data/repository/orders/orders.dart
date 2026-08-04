import 'package:dartz/dartz.dart';
import 'package:menu_servex/data/data_sources/orders/orders_firebase_servise.dart';
import 'package:menu_servex/data/model/orderDetails/order_details.dart';
import 'package:menu_servex/domain/repository/orders/orders.dart';
import 'package:menu_servex/service_locator.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  @override
  Future<Either> confirmOrderDetails(OrderDetailsModel orderDetails) async{
           return await sl<OrdersFirebaseServise>().confirmOrderDetails( orderDetails);

  }

  @override
  Future<Either<dynamic, dynamic>> getUserOrders() async{
    return await sl<OrdersFirebaseServise>().getUserOrders();
  }

}