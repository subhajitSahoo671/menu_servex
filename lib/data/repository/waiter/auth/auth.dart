import 'package:dartz/dartz.dart';
// import 'package:menu_servex/data/data_sources/auth/auth_firebase_servise.dart';
import 'package:menu_servex/data/data_sources/waiter/auth/waiter_auth_firebase_servise.dart';
import 'package:menu_servex/data/model/auth/sign_in.dart';
// import 'package:menu_servex/data/model/auth/sign_up.dart';
// import 'package:menu_servex/domain/repository/auth/auth.dart';
import 'package:menu_servex/domain/repository/waiter/auth/auth.dart';
import 'package:menu_servex/service_locator.dart';

class WaiterAuthRepositoryImpl extends WaiterAuthRepository{
  @override
  Future<Either> signIn(SignInModel signInWaiterCredentials) {
    return sl<WaiterAuthFirebaseServise>().signIn(signInWaiterCredentials);
  }

  // @override
  // Future<Either> signUp(SignUpModel signUpUserCredentials) {

  //      return sl<AuthFirebaseServise>().signUp(signUpUserCredentials,);

  // }
  
  // @override
  // Future<String?> getAccessToken() async{
  //   return await sl<AuthFirebaseServise>().getAccessToken();
  // }

}