import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_text/repositories/message_repositories.dart';
import 'package:flutter/cupertino.dart';

import '../models/message_model.dart';

class MessageViewModel with ChangeNotifier{

  Stream<QuerySnapshot<Map<String, dynamic>>>? _messages;
  Stream<QuerySnapshot<Map<String, dynamic>>>? get messages=> _messages;







  Future<void> sendMessage(String msg, String fromId, String toId) async{
    try{
      await MessageRepository().sendMessage(msg, fromId, toId);

    } catch(e){
      rethrow;
    }
  }


  Future<void> showMessages(String? fromId, String? toId)async {
    try{

      _messages = await MessageRepository().showMessages(fromId, toId);
      notifyListeners();

    }catch(e){
      rethrow;

    }
  }



}