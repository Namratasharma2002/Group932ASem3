import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isOnline = true; // Example boolean to determine online/offline status

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          flexibleSpace: _appBar(),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                // stream: APIs.firestore.collection("users").snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      // return const Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final list = [];

                      if (list.isNotEmpty) {
                        return ListView.builder(
                          itemCount: list.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Text("Message: ${list[index]}");
                          },
                        );
                      } else {
                        return Center(
                          child: Text(
                            "Say Hiii 👋",
                            style: TextStyle(fontSize: 30),
                          ),
                        );
                      }
                  }
                },
              ),
            ),
            _chatInput(),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Back button
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          radius: 30,
          child: Icon(CupertinoIcons.person),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Username", // Replace with actual username from database
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    isOnline ? "Online" : "Offline",
                    style: TextStyle(
                      fontSize: 12,
                      color: isOnline ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 20,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isOnline ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chatInput() {
    final mq = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.emoji_emotions,
                    color: Colors.blueAccent,
                    size: 25,
                  ),
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Write a message....',
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.image,
                    color: Colors.blueAccent,
                    size: 26,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.blueAccent,
                    size: 26,
                  ),
                ),
                SizedBox(width: mq * .02),
              ],
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {},
          minWidth: 0,
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
          shape: const CircleBorder(),
          color: Colors.blueAccent,
          child: const Icon(
            Icons.arrow_forward_outlined,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
    );
  }
}
