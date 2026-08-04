import 'package:dartz/dartz.dart';
import 'package:menu_servex/core/usecase/usecase.dart';
import 'package:menu_servex/domain/repository/auth/auth.dart';
import 'package:menu_servex/service_locator.dart';

class SignInUsecase implements Usecase<Either,dynamic>{
  @override
  Future<Either> call({param}) async{
    return await sl<AuthRepository>().signIn(param);
  }
}