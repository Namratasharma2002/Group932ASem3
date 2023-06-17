import 'package:ez_text/view/registration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomeScreen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
            right: -145,
            child: Container(
              height: 690,
              width: 650,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2977F6),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 5,
            right: 20,
            child: Image.asset(
              'assets/images/Login.png',
              height: 150,
              width: 150,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 200.0, bottom: 16.0),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Username or Email',
                      filled: true,
                      fillColor: Color(0xFF88ADEA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Color(0xFF88ADEA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 5), // Reduced the gap here
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        // Add your forgot password action here
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF2086B1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF35809F),
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RegistrationPage()));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
