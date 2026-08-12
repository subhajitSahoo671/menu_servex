import 'package:dartz/dartz.dart';
import 'package:menu_servex/data/model/auth/sign_in.dart';
// import 'package:menu_servex/data/model/auth/sign_up.dart';

abstract class WaiterAuthRepository {
  Future<Either> signIn( SignInModel signInWaiterCredentials);
  // Future<Either> signUp( SignUpModel signUpUserCredentials);
  // Future<String?> getAccessToken();
}