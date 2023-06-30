import 'package:ez_text/models/message_model.dart';
import 'package:ez_text/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({Key? key, required this.message}) : super(key: key);

  final MessageModel message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {

  late AuthViewModel _authViewModel;

  void initState(){
    _authViewModel= Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    return Consumer<AuthViewModel>(
        builder: (context, _authViewModel, child)=>
        _authViewModel.loggedInUser!.id == widget.message.fromId ? _greenMessage(): _blueMessage());

  }

  Widget _greenMessage(){
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 10),

          decoration: BoxDecoration(color: Colors.blue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              topRight: Radius.circular(30),
          )),
          child: Text(widget.message.msg as String,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black26
          )),
        ),
      ],
    );

  }

  Widget _blueMessage(){
    return Container(
      child: Text("hey"),
    );
  }
}
