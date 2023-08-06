



import 'package:ez_text/screens/Account/edit_profile_screen.dart';
import 'package:ez_text/screens/auth/login_screen.dart';
import 'package:ez_text/screens/auth/register_screen.dart';
import 'package:ez_text/screens/chat/chat_screen.dart';
import 'package:ez_text/screens/user_list/user_selection.dart';
import 'package:ez_text/services/notification_service.dart';
import 'package:ez_text/view_model/auth_viewmodel.dart';
import 'package:ez_text/view_model/global_ui_viewmodel.dart';
import 'package:ez_text/view_model/message_viewmodel.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "EzText", 
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService.initialize();
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider (create: (_) => GlobalUIViewModel()),
        ChangeNotifierProvider (create: (_) => AuthViewModel()),

        ChangeNotifierProvider(create: (_) => MessageViewModel()),


        ChangeNotifierProvider (create: (_) => MessageViewModel()),


      ],

    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

      initialRoute: "/login",
      routes: {
        "/register": (BuildContext context) => RegisterScreen(),
        "/userselect": (BuildContext context) => UserSelection(),
        "/login": (BuildContext context) => LoginScreen(),
        "/chatscreen": (BuildContext context) => ChatScreen(),
        "/editprofile": (BuildContext context) => EditProfile(),
        // "/Hidechat": (BuildContext context) => Hidechat(),







      },
    )
    );
  }
}


