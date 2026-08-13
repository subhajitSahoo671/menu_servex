import 'package:dartz/dartz.dart';
import 'package:menu_servex/core/usecase/usecase.dart';
import 'package:menu_servex/domain/repository/cook/orders/orders.dart';
// import 'package:menu_servex/domain/repository/menu/menu.dart';
// import 'package:menu_servex/domain/repository/orders/orders.dart';
// import 'package:menu_servex/domain/repository/waiter/orders/orders.dart';
import 'package:menu_servex/service_locator.dart';

class  UpdateCookStatusUsecase implements Usecase<Either,dynamic>{
  @override
  Future<Either> call({param}) async{
    return await sl<CookOrdersRepository>().updateStatus(param);
  }
}