import 'package:dartz/dartz.dart';
import 'package:menu_servex/data/model/auth/sign_in.dart';
import 'package:menu_servex/data/model/auth/sign_up.dart';

abstract class AuthRepository {
  Future<Either> signIn( SignInModel signInUserCredentials);
  Future<Either> signUp( SignUpModel signUpUserCredentials);
  // Future<String?> getAccessToken();
}