import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../view_model/auth_viewmodel.dart';



class UserSelection extends StatefulWidget {


  const UserSelection({Key? key}) : super(key: key);


  @override
  State<UserSelection> createState() => _UserSelectionState();
}

class _UserSelectionState extends State<UserSelection> {

    late AuthViewModel _authViewModel;
    void initState() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      });
      super.initState();
    }







    //Getting all user id added as friends
  static Stream<QuerySnapshot<Map<String,dynamic>>> getMyUsersId(String? id) {
     return fireStore.
    collection('users').
    doc(id).
    collection('my_friends').
    snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(List<String> userIds){
    log("user id : $userIds");
    return fireStore.collection("users").where('id', whereIn: userIds).snapshots();
  }



  static TextEditingController emailController= TextEditingController();
  //ADDING A USER FUNCTION
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //adding a user
  static Future<bool> addChatUser(String Email, String? id) async{
    final data= await fireStore.collection('users').where('email',isEqualTo:emailController.text).get();
    if(data.docs.isNotEmpty){
      fireStore.collection('users').doc(id).
      collection('my_friends').doc(data.docs.first.id).set({});
      return true;
    }
    return false;
  }


//Testing user registration
  void testCreation() async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "NewDummy@gmail.com", password: "Hello123!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Select User"),
      ),
      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xff4e91fb),
                height: MediaQuery.of(context).size.height - 200,
                width: double.infinity,

                // Building a Stream

                child: Consumer<AuthViewModel>(

                  builder: (context, AuthViewModel, child)=>



                    StreamBuilder(

                    stream: getMyUsersId(AuthViewModel.loggedInUser?.id),

                    builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const Center(
                                child: CircularProgressIndicator());

                          case ConnectionState.active:
                          case ConnectionState.done:
                            return StreamBuilder(
                              stream: getAllUsers(
                                snapshot.data?.docs.map((e) => e.id).toList() ??
                                    [],

                              ),

                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                  case ConnectionState.none:
                                    return const Center(
                                        child: CircularProgressIndicator());

                                  case ConnectionState.active:
                                  case ConnectionState.done:
                                  // List<String>? data2= snapshot.data?.docs.map((e) => e.id).toList();

                                    if (snapshot.hasData &&
                                        snapshot.data != null) {
                                      return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          Map<String,
                                              dynamic> userMap = snapshot.data!
                                              .docs[index].data() as Map<
                                              String,
                                              dynamic>;


                                          return ListTile(
                                            title: Text(userMap['name']),
                                            subtitle: Text(userMap['email']),

                                          );
                                        },
                                      );
                                    }
                                    else {
                                      return const Center(
                                          child: Text("NO connections Found")
                                      );
                                    }
                                }
                                // List<String>? data2 = snapshot.data?.docs.map((e)=>e.id).toList();

                              },
                            );
                        }

                    }
                  ),
                )
              ),
              Container(

                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xff4e91fb),

                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: "Enter email",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),


                      Consumer<AuthViewModel>(
                        builder: (context, AuthViewModel, child)=>
                        IconButton(
                            iconSize: 50,
                            color: Colors.white,

                            onPressed: () async{
                              if(emailController.text.isNotEmpty) {
                                await addChatUser(emailController.text, _authViewModel.loggedInUser?.id).then((value){
                                  if(!value){
                                    final snackBar= SnackBar(content: Text("Enter a valid email"));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                }
                                );
                              }
                        },

                            icon:Icon(Icons.add_circle) ),
                      ),
                    ],
                  ),
                ),

              ),
            ],
          ),
        ),
      )
    );
  }
}
