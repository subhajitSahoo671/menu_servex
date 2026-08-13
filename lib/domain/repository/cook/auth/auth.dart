import 'package:dartz/dartz.dart';
import 'package:menu_servex/data/model/auth/sign_in.dart';
// import 'package:menu_servex/data/model/auth/sign_up.dart';

abstract class CookAuthRepository {
  Future<Either> signIn( SignInModel signInCookCredentials);
  // Future<Either> signUp( SignUpModel signUpUserCredentials);
  // Future<String?> getAccessToken();
}