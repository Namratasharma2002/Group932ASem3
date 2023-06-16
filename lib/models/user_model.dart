import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? image;
  String? about;
  String? name;
  String? createdAt;
  bool? isOnline;
  String? id;
  String? uid;
  String? email;
  String? password;
  String? pushToken;

  UserModel({
    this.image,
    this.about,
    this.name,
    this.createdAt,
    this.isOnline,
    this.id,
    this.uid,
    this.email,
    this.password,
    this.pushToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    image: json["image"],
    about: json["about"],
    name: json["name"],
    createdAt: json["created_at"],
    isOnline: json["is_online"],
    id: json["id"],
    uid: json["uid"],
    email: json["email"],
    password: json["password"],
    pushToken: json["push_token"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "about": about,
    "name": name,
    "created_at": createdAt,
    "is_online": isOnline,
    "id": id,
    "uid": uid,
    "email": email,
    "password": password,
    "push_token": pushToken,
  };



factory UserModel.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) => UserModel(
    image: json["image"],
    about: json["about"],
    name: json["name"],
    createdAt: json["created_at"],
    isOnline: json["is_online"],
    id: json["id"],
    uid: json["uid"],
    email: json["email"],
    password: json["password"],
    pushToken: json["push_token"],
  );
}
