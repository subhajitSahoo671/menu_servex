
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:menu_servex/data/model/auth/sign_in.dart';

abstract class CookAuthFirebaseServise {
  Future<Either> signIn(SignInModel signInCookCredentials);
}

class CookAuthFirebaseServiseImpl extends CookAuthFirebaseServise {
  @override
  Future<Either<dynamic, dynamic>> signIn(SignInModel signInCookCredentials) async{
    try {
         await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInCookCredentials.email,
        password: signInCookCredentials.password,
      );

       User? user = FirebaseAuth.instance.currentUser;

          var docSnapshot = await FirebaseFirestore.instance.collection("cook").doc(user?.uid).get();
  
        if (docSnapshot.exists) {
            // ignore: avoid_print
      print("Login Successful");

      return Right("Signin Successful");
        } else {
           await FirebaseAuth.instance.signOut();
          return left("invalid-email");
        }
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == "invalid-email") {
        message = "No user found for that email";
      } else if (e.code == "invalid-cradential") {
        message = "Wrong password provided for that user";
      } else {
        message = e.code.toString();
      }

      return left(message);
    }
  }
  
}