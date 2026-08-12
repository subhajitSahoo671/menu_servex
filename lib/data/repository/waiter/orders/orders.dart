import 'package:dartz/dartz.dart';
// import 'package:menu_servex/data/data_sources/orders/orders_firebase_servise.dart';
import 'package:menu_servex/data/data_sources/waiter/orders/waiter_orders_firebase_servise.dart';
import 'package:menu_servex/data/model/updateStatus/update_status.dart';
// import 'package:menu_servex/data/model/orderDetails/order_details.dart';
import 'package:menu_servex/domain/repository/waiter/orders/orders.dart';
// import 'package:menu_servex/domain/repository/orders/orders.dart';
import 'package:menu_servex/service_locator.dart';

class WaiterOrdersRepositoryImpl extends WaiterOrdersRepository {
  // @override
  // Future<Either> confirmOrderDetails(OrderDetailsModel orderDetails) async{
  //          return await sl<OrdersFirebaseServise>().confirmOrderDetails( orderDetails);

  // }

  @override
  Future<Either<dynamic, dynamic>> getOrders() async{
    return await sl<WaiterOrdersFirebaseServise>().getOrders();
  }

  @override
  Future<Either<dynamic, dynamic>> updateStatus(UpdateStatusModel cradentials) async{
        return await sl<WaiterOrdersFirebaseServise>().updateStatus(cradentials);
       
  }

}