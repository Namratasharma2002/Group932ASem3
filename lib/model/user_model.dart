// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? username;
  String? email;
  String? password;

  UserModel({
    this.username,
    this.email,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json["username"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "password": password,
  };
  factory UserModel.fromFirebaseSnapshot(DocumentSnapshot doc){
    final data= doc.data() as Map<String,dynamic>;
    data["id"]=doc.id;
    return UserModel.fromJson(data);
  }

}

