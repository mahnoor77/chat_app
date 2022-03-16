import 'package:chatapp/net/database.dart';
import 'package:chatapp/net/sharedPref_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatapp/net/sharedPref_helper.dart';
import 'package:chatapp/net/flutterfire.dart';
import 'package:chatapp/views/signup.dart';
import 'package:chatapp/views/signin.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  final String email;

  const ChatScreen({Key? key, required this.username, required this.email})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String chatRoomId = "";
  String MessageId = "";

  String myName = '';
  //String myEmail = '';
  TextEditingController txt = new TextEditingController();
  //Stream messageStream;
  //Stream? messageStream;
  getMyInfromSharedPreference() async {
    myName = await FirebaseAuth.instance.currentUser!.email.toString();
    //await sharedPreferenceHelper.getUserDisplayName().toString();
    //myEmail = await sharedPreferenceHelper.getUserDisplayName().toString();
    var myname1 = await myName.replaceAll("@gmail.com", "");
    chatRoomId = await getChatRoomIdByUsername(widget.username, myname1);
  }

  getChatRoomIdByUsername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  //addMessages(bool sendClicked) {
  //if (sendClicked == true) {
  //String message = txt.text;
  //var lastMessagets = DateTime.now();
  //Map<String, dynamic> msgInfoMap = {
  //"message": message,
  //"name": myName,
  //"ts": lastMessagets
  // };
  //if (MessageId == "") {
  //MessageId = randomAlphaNumeric(12);
  //}
  //addMessage(chatRoomId, MessageId, msgInfoMap).then((value) {
  //Map<String, dynamic> lstMsgInfo = {
  //"lastmassage": message,
  //"lastmessageSendts": lastMessagets,
  //"lastmessageSendby": myName
  //};
  //updateLstMessage(chatRoomId, lstMsgInfo);

  //   if (sendClicked) {
  //   txt.text = "";
  // MessageId = "";
  // }
  //});
  //}
  //}

  //getAndSetMessages() async {
  //  messageStream = await getChatRoomMessages(chatRoomId);
  //setState(() {});
  //}

  //Widget chatMessages() {
  //return StreamBuilder(
  //stream: messageStream,
  //builder: (context, AsyncSnapshot snapshot) {
  //return snapshot.hasData
  //  ? ListView.builder(
  //    itemCount: snapshot.data?.docs.length,
  //  itemBuilder: (context, index) {
  //  DocumentSnapshot ds = snapshot.data.docs[index];
  //return Text(ds["message"]);
  //})
  //: Center(child: CircularProgressIndicator());
  //},
  //);
  // }

  doThisOnLaunch() async {
    await getMyInfromSharedPreference();
    //await getAndSetMessages();
  }

  void initState() {
    super.initState();
    doThisOnLaunch().whenComplete(() {
      setState(() {});
    });
    // getAndSetMessages().whenComplete(() {
    // setState(() {});
    //});
  }

  @override
  Widget build(BuildContext context) {
    //var storeMessage = FirebaseFirestore.instance.collection("msgs");
    //var storeMessage1 = FirebaseFirestore.instance
    //  .collection("msgs")
    //.orderBy("time")
    //.snapshots();
    print("this is chatroom id:${chatRoomId}");
    print("this is myName:${myName}");

    var msg1 = FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        actions: [
          IconButton(
              onPressed: () async {
                await signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: // Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //mainAxisSize: MainAxisSize.max,
          //c//hildren: [
          Container(
        child: Stack(children: [
          // chatMessages(),
          //ListView(
          Expanded(
            child: Container(
              // child: SingleChildScrollView(
              // scrollDirection: Axis.vertical,
              child: Align(
                alignment: Alignment.topCenter,
                child: StreamBuilder<QuerySnapshot>(
                  stream: msg1,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());

                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, int index) {
                        return Card(
                          child: ListTile(
                            onTap: () async {
                              // String name;
                              //name = snapshot.data.docs[index]['name'];
                              //String email;
                              //email = snapshot.data.docs[index]['email'];
                              //myName = await FirebaseAuth.instance.currentUser!.email
                              //  .toString();

                              //var chatRoomId = getChatRoomIdByUsername(name, myName);

                              //Map<String, dynamic> chatRoomInfoMap = {
                              //"users": [myName, name]
                              //};
                              //createChatRoom(chatRoomId, chatRoomInfoMap);
                              // chatAppBar(name);
                              //  Navigator.push(
                              //    context,
                              //  MaterialPageRoute(
                              //    builder: (context) => ChatScreen(
                              //        name,
                              //    email,
                              //    )));
                            },
                            title: // Padding(
                                //padding: const EdgeInsets.all(15.0),
                                //child:
                                Row(
                                    mainAxisAlignment: snapshot.data.docs[index]
                                                ['name'] ==
                                            widget.username
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                    children: [
                                  Container(
                                      padding: EdgeInsets.all(21),
                                      decoration: BoxDecoration(
                                          color: snapshot.data.docs[index]
                                                      ['name'] ==
                                                  widget.username
                                              ? Colors.blue.withOpacity(0.4)
                                              : Colors.amber.withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                      child: Text(
                                          snapshot.data.docs[index]['message']))
                                ]),
                          ),
                          //  subtitle: Text(myName),
                          // leading: CircleAvatar(
                          // backgroundColor: Colors.amber,
                          //),
                          // ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          // ),
          SizedBox(
            height: 50,
          ),
          //Padding(
          //padding: const EdgeInsets.all(8.0),
          //child: Container(
          //child:
          //Align(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Container(
                  child: Expanded(
                      child: TextField(
                    controller: txt,
                    // onChanged: addMessages(false),
                    decoration: InputDecoration(hintText: "Type here"),
                  )),
                ),
                IconButton(
                    onPressed: () async {
                      //addMessages(true);
                      String message = txt.text;
                      print(message);
                      //var myName =
                      //   await FirebaseAuth.instance.currentUser!.email.toString();

                      print(myName);
                      String myname1 = myName.replaceAll("@gmail.com", "");

                      print(widget.username);

                      var lastMessagets = DateTime.now();

                      print(chatRoomId);

                      Map<String, dynamic> msgInfoMap = {
                        "message": message,
                        "name": myname1,
                        "ts": lastMessagets
                      };
                      //(MessageId == "") {
                      MessageId = randomAlphaNumeric(12);
                      // }
                      await addMessage(
                          chatRoomId, MessageId, msgInfoMap); //.then((value) {
                      //Map<String, dynamic> lstMsgInfo = {
                      //"lastmassage": message,
                      //"lastmessageSendts": lastMessagets,
                      //"lastmessageSendby": myName
                      //};
                      //updateLstMessage(chatRoomId, lstMsgInfo);

                      //   if (sendClicked) {
                      //   txt.text = "";
                      // MessageId = "";
                      // }
                      //  });
                      // await storeMessage.add({
                      // "message": txt.text.trim(),
                      //"user": widget.username,
                      //"email": widget.email,
                      //"time": DateTime.now()
                      //});
                      txt.clear();
                    },
                    icon: Icon(Icons.send))
              ]),
            ),
          ),
          //  ),
        ]),
      ),

      // ),
      // ),
      //   ),
      // ])
      // )
      //  ]),
    );
  }
}
