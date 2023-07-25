import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_text/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'dart:developer' as developer;

class AuthRepository {
  CollectionReference<UserModel> userRef = FirebaseService.db
      .collection("users")
      .withConverter<UserModel>(
    fromFirestore: (snapshot, _) {
      return UserModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) {
      return model.toJson();
    },
  );

  Future<UserCredential?> register(UserModel user) async {
    try {
      final response =
      await userRef.where("name", isEqualTo: user.name!).get();
      print("RESPONSE ${response}");
      UserCredential uc = await FirebaseService.firebaseAuth
          .createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

      user.uid = uc.user!.uid;

      await userRef.add(user).then((DocumentReference doc) async {
        await userRef.doc(doc.id).update({
          "id": doc.id,
        });
      });
      return uc;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential uc = await FirebaseService.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return uc;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel> getUserDetail(String uid, String? pushToken) async {
    try {
      final response = await userRef.where("uid", isEqualTo: uid).get();
      var user = response.docs.single.data();
      user.pushToken = pushToken;
      await userRef.doc(user.id).set(user);
      return user;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel> getUserDetailWithEmail(String email) async {
    try {
      final response = await userRef.where("email", isEqualTo: email).get();
      var user = response.docs.single.data();
      return user;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel> getUserDetailWithId(String id) async {
    try {
      final response = await userRef.where("id", isEqualTo: id).get();
      var user = response.docs.single.data();
      print(user);
      return user;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel?> addUser(UserModel model, String id, String email) async {
    try {
      final response = await userRef.where("email", isEqualTo: email).get();

      userRef.doc(id).update({
        "myFriends": FieldValue.arrayUnion([response.docs.first.id]),
      });

      model.myFriends?.add(response.docs.first.id);

      return model;
    } catch (err) {
      rethrow;
    }
  }


  Future<bool> changePassword(String password, String id) async {
    try {
      var res = await FirebaseService.firebaseAuth.currentUser?.updatePassword(password);
      userRef.doc(id).update({
        "password": password,
      });
      return true;
    } catch (err) {
      rethrow;
    }
  }



  Future<void> removeFriend(String loggedIn, String friendId) async {
    try {
      await userRef.doc(loggedIn).update({
        "myFriends": FieldValue.arrayRemove([friendId]),
      });
      // final response = await userRef.doc(loggedIn).get();
      //
      // if (response!=null) {
      //   String userId = response.docs.first.id;
      //
      // }
    } catch (err) {
      rethrow;
    }
  }



  
  Future<void> updateUser(UserModel user) async {
    await userRef.doc(user.id).set(user);
  }
}
