import 'package:cloud_firestore/cloud_firestore.dart';

class registrationRepo{
  final instance= FirebaseFirestore.instance.collection("Register");

  // Map<String, dynamic> get data => null;
  Future<dynamic> createProduct (Map<String, dynamic> data) async{
  try {
    final result=await instance.add(data);
    return result;

  }
  catch(e){
    print(e);
  }
}
Future<List<dynamic>> fetchAllProducts() async{
  try{
    final result=(await instance.get()).docs;
    return result;

  }catch(e){
    return [];
  }
}
}