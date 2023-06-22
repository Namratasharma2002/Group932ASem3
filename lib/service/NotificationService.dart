import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  static FlutterLocalNotificationsPlugin _notificationsPlugin=FlutterLocalNotificationsPlugin();

  static void initialize(){
    _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

    final InitializationSettings initializationSettings=InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    _notificationsPlugin.initialize(initializationSettings,
    onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse);

  }
  static onDidReceiveNotificationResponse(NotificationResponse? response){}
  static Future<void> displayText({required String title, required String body}) async{
    final id= DateTime.now().microsecondsSinceEpoch ~/1000;
    final NotificationDetails notificationDetails=NotificationDetails(
      android: AndroidNotificationDetails(
        "myapp",
        "my app chanel",
        channelDescription: "Channel Des",
        priority: Priority.high,
        importance: Importance.high
      )
    );
    _notificationsPlugin.show(id, title, body, notificationDetails);
  }
}