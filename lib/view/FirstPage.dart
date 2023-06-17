import 'package:ez_text/view/HomeScreen.dart';
import 'package:ez_text/view/Login.dart';
import 'package:ez_text/view/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // if(FirebaseAuth.instance.currentUser != null){
  //   Navigator.pushReplacement(context, builder:(_)=> HomeScreen())
  // }else{
  // Navigator.pushReplacement(context, builder:(_)=> ())
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),
          Positioned(
            top: -200,
            right: -100,
            child: Container(
              height: 500,
              width: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2977F6),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/Login.png',
                      width: 130,
                      height: 130,
                    ),
                    SizedBox(width: 16.0),
                    Image.asset(
                      'assets/images/SignUp.png',
                      width: 130,
                      height: 130,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 180),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF2086B1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RegistrationPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF69B3D3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
