import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_text/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/firebase_service.dart';

class AuthRepository{
  CollectionReference<UserModel> userRef = FirebaseService.db.collection("users")
      .withConverter<UserModel>(
    fromFirestore: (snapshot, _) {
      return UserModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );



  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential uc = await FirebaseService.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
           return uc;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel> getUserDetail(String id) async {
    try {
      final response = await userRef
          .where("user_id", isEqualTo: id).get();

      var user = response.docs.single.data();
      user.fcm="";
      await userRef.doc(user.id).set(user);
      return user;
    } catch (err) {
      rethrow;
    }
  }



  Future<void> logout() async {
    try {
      await FirebaseService.firebaseAuth.signOut();
    } catch (err) {
      rethrow;
    }
  }
}