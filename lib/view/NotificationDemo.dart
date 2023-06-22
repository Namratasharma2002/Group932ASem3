import 'package:ez_text/service/NotificationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsDemo extends StatefulWidget {
  const NotificationsDemo({super.key});

  @override
  State<NotificationsDemo> createState() => _NotificationsDemoState();
}

class _NotificationsDemoState extends State<NotificationsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NotificationDemo"),),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            NotificationService.displayText(title: "hello", body: "Body here");
          }, child: Text("Notification text Only")),
          ElevatedButton(onPressed: (){
            NotificationService.displayText(title: "hello", body: "Body here");
          }, child: Text("Notifications With Image")),

        ],
      ),

    );
  }
}
