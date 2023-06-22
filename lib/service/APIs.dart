import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class APIs{
  static FirebaseAuth auth= FirebaseAuth.instance;
  static FirebaseFirestore firestore= FirebaseFirestore.instance;

  static late UserModel me;
  static User get user=> auth.currentUser!;
  static late final time;

  static Future<bool> userExists() async {
    return (await firestore
        .collection("users")
        .doc(user.uid)
        .get())
        .exists;
  }

  static Future<void> getSelfInfo() async {
    await firestore
        .collection("users")
        .doc(user.uid)
        .get().then((user) {
          if(user.exists){
            me=UserModel.fromJson(user.data()!);
          }else{
            createUser().then((value) => getSelfInfo());
          }
    });
  }





  static Future<void> createUser() async{
    time =DateTime.now().microsecondsSinceEpoch.toString();


  final chatUser= UserModel(
    id: user.uid,
    name: user.displayName.toString(),
    about: "Hey I am using EXText",
    image: user.photoURL.toString(),
    createdAt: time,
    isOnline: false,
    pushToken: ""
  );

 return(await firestore.collection('users')
      .doc(user.uid)
      .set(chatUser.toJson()));
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllUsers(){
    return firestore
        .collection("users")
        .where("id", isNotEqualTo: user.uid)
        .snapshots();

  }
  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllMessages(){
    return firestore
        .collection("messages")
        .where("id", isNotEqualTo: user.uid)
        .snapshots();

  }

}