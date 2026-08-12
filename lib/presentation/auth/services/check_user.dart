import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckUserService{
   
   Future<String> checkUserRole() async{
      try {
          User? user = FirebaseAuth.instance.currentUser;
          if (user == null) return "no-user";

          final results = await Future.wait([
            FirebaseFirestore.instance.collection('waiter').doc(user.uid).get(),
            FirebaseFirestore.instance.collection('Users').doc(user.uid).get(),
          ]);

          final waiterSnapshot = results[0];
          final customerSnapshot = results[1];

          if (waiterSnapshot.exists) {
            return 'waiter';
          } else if (customerSnapshot.exists) {
            return 'customer';
          } else {
            await FirebaseAuth.instance.signOut();
            // print("checkUserRoleError: User role not found in Firestore.");
            return 'invalid-email';
          }
      } on FirebaseException catch (e) {
        print("checkUserRoleError: $e");
        return "${e.message}";
      }
   }
}