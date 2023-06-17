import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_text/model/user_model.dart';

class registrationRepo{
  final instance= FirebaseFirestore.instance.collection("Register").
      withConverter(fromFirestore: (snapshot,_){
        return UserModel.fromFirebaseSnapshot(snapshot);
  }, toFirestore: (UserModel model,_)=>model.toJson());

  // Map<String, dynamic> get data => null;
  Future<dynamic> addInfo (UserModel data) async{
  try {
    final result=await instance.add(data);
    return result;

  }
  catch(e){
    print(e);
  }
}
Future<List<dynamic>> getInfo() async{
  try{
    final result=(await instance.get()).docs;
    return result;

  }catch(e){
    return [];
  }
}
Future<void> deleteInfo(String id) async{
    try{
      await instance.doc(id).delete();

    }catch(e){
      print(e);
      rethrow;

    }
}

  Future<void> updateInfo(String id,UserModel data) async{
    try{
      await instance.doc(id).set(data);

    }catch(e){
      print(e);
      rethrow;

    }
  }

// Future<dynamic> getOneProduct(String id ) async{
//     try{
//       final product= await
//     }
// }
}