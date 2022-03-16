import 'dart:html';

import 'package:chatapp/net/database.dart';
import 'package:chatapp/views/conversation_screens.dart';
import 'package:chatapp/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/net/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatapp/net/sharedPref_helper.dart';
import 'package:chatapp/net/flutterfire.dart';
import 'package:chatapp/views/signup.dart';
import 'package:chatapp/views/signin.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  var db = FirebaseFirestore.instance.collection("Users").snapshots();
  String myName2 = '';
  //String myEmail = '';
  String myname3 = '';
  TextEditingController txt = new TextEditingController();

  getMyInfromSharedPreference() async {
    myName2 = await FirebaseAuth.instance.currentUser!.email.toString();
    //await sharedPreferenceHelper.getUserDisplayName().toString();
    //myEmail = await sharedPreferenceHelper.getUserDisplayName().toString();
    myname3 = await myName2.replaceAll("@gmail.com", "");
  }

  getChatRoomIdByUsername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  doThisOnLaunch() async {
    await getMyInfromSharedPreference();
    //await getAndSetMessages();
  }

  void iniState() {
    super.initState();
    doThisOnLaunch().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Scaffold(
        // appBar: HomeView(),
        appBar: AppBar(
          title: Text("ChatApp"),
          actions: [
            IconButton(
                onPressed: () async {
                  await signOut();
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                icon: Icon(Icons.logout)),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: db,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, int index) {
                if (snapshot.data.docs[index]['name'] == myName2) {
                  return SizedBox(height: 2);
                } else {
                  return Card(
                    child: ListTile(
                      onTap: () async {
                        String name;
                        name = await snapshot.data.docs[index]['name'];
                        print("name is ${name}");
                        String email;
                        email = await snapshot.data.docs[index]['email'];
                        print("email is ${email}");

                        String myName = await FirebaseAuth
                            .instance.currentUser!.email
                            .toString();
                        String myname1 = myName.replaceAll("@gmail.com", "");
                        print("myName  is ${myName}");
                        print("myname1 is ${myname1}");
                        //print(myname1);
                        var chatRoomId = getChatRoomIdByUsername(name, myname1);

                        Map<String, dynamic> chatRoomInfoMap = {
                          "users": [myname1, name]
                        };
                        createChatRoom(chatRoomId, chatRoomInfoMap);
                        // chatAppBar(name);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                      username: name,
                                      email: email,
                                    )));
                      },

                      title: Text(snapshot.data.docs[index]['name']),
                      // subtitle: Text(myName),
                      leading: CircleAvatar(
                        backgroundColor: Colors.amber,
                      ),
                    ),
                  );
                }
                //  } //else {
                //return SizedBox(
                //height: 10,
                //);
                // }
              },
            );
          },
        ),
      ),
    );
  }
}
