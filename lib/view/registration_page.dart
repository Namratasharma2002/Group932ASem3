import 'package:ez_text/model/user_model.dart';
import 'package:ez_text/repositories/registrationRepo.dart';
import 'package:ez_text/view/HomeScreen.dart';
import 'package:ez_text/view/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/registration_viewmodel.dart';
import 'package:flutter/services.dart' show rootBundle;


class RegistrationPage extends StatelessWidget {


  void saveData(){
    final data= UserModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
 registrationRepo rr = registrationRepo();
 rr.addInfo(data);
  }
  TextEditingController nameController =  TextEditingController();
  TextEditingController numberController =  TextEditingController();
  TextEditingController emailController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();


  void register(){
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Account'),
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
              height: 635,
              width: 635,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2977F6),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/SignUp.png',
              height: 110,
              width: 150,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: nameController,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      filled: true,
                      fillColor: Color(0xFF88ADEA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: numberController,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      filled: true,
                      fillColor: Color(0xFF88ADEA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Color(0xFF88ADEA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Color(0xFF88ADEA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 53),
                  ElevatedButton(
                    onPressed: () {

                      register();
                      saveData();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));


                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF2086B1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Consumer<RegistrationViewModel>(
                      builder: (context, viewModel, child) {
                        if (viewModel.isRegistrationLoading) {
                          return CircularProgressIndicator();
                        } else {
                          return Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: Color(0xFF35809F),
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));
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
