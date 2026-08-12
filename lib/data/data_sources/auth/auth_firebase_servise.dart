import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:menu_servex/data/model/auth/sign_in.dart';
import 'package:menu_servex/data/model/auth/sign_up.dart';

abstract class AuthFirebaseServise {
  Future<Either> signUp(SignUpModel createUserCredentials);
  Future<Either> signIn(SignInModel signInUserCredentials);
  // Future<String?> getAccessToken();
}

class AuthFirebaseServiseImpl extends AuthFirebaseServise {
  @override
  Future<Either> signIn(SignInModel signInUserCredentials) async{
    try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInUserCredentials.email,
        password: signInUserCredentials.password,
      );

       User? user = FirebaseAuth.instance.currentUser;

          var docSnapshot = await FirebaseFirestore.instance.collection("Users").doc(user?.uid).get();
  
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

  @override
  Future<Either> signUp(SignUpModel createUserCredentials) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserCredentials.email,
        password: createUserCredentials.password,
      );

     await FirebaseFirestore.instance.collection("Users").doc(data.user?.uid).set({
        "id": data.user?.uid,
        "name": createUserCredentials.fullName,
        "email": data.user?.email,
      });

      print("Singup Successful");

      return Right("Signup Successful");
    } on FirebaseException catch (e) {
       String message = "";

      if (e.code == "weak-password") {
        message = "The password provided is too weak";
      } else if (e.code == "email-already-in-use") {
        message = "An account already exists with that email";
      } else {
        message = e.code.toString();
      }
      return left(message);
    }
  }

  // @override
  // Future <String?> getAccessToken() async {
  //   User? user = FirebaseAuth.instance.currentUser;

  //   if (user != null) {
  //     String? idToken = await user.getIdToken();
  //     return idToken;
  //   }
  //   return null;
  // }
}
