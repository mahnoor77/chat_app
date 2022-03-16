import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

var db = FirebaseFirestore.instance.collection("Users");
//var db1 = FirebaseFirestore.instance.collection("Messages");

final CollectionReference bb = FirebaseFirestore.instance.collection("Users");

Future<bool> InsertData(String name, String email) async {
  try {
    //var  db = await FirebaseFirestore.instance.collection("Users");
    await db.add({"name": name, "email": email});
    print('doneee');
    return true;
  } catch (e) {
    print("not doneee");

    print(e);
    return false;
  }
}

Future<bool> InsertMessageData(
    String name, String email, String message) async {
  try {
    //var  db = await FirebaseFirestore.instance.collection("Users");
    //  await db1.add({"name": name, "email": email, "message": message});
    print('doneee');
    return true;
  } catch (e) {
    print("not doneee");

    print(e);
    return false;
  }
}

Future<Stream<QuerySnapshot>> getUserByuserName(String username) async {
  return await FirebaseFirestore.instance
      .collection("Users")
      .where("name", isEqualTo: username)
      .snapshots();

  //return true;
}

Future addMessage(
    String chatRoomId, String messageId, Map<String, dynamic> msgInfo) async {
  return await FirebaseFirestore.instance
      .collection("chatroom")
      .doc(chatRoomId)
      .collection("chats")
      .doc(messageId)
      .set(msgInfo);
}

Future updateLstMessage(
    String chatRoomId, Map<String, dynamic> lastmsgInfomap) async {
  return await FirebaseFirestore.instance
      .collection("chatroom")
      .doc(chatRoomId)
      .collection("chats")
      .doc(chatRoomId)
      .update(lastmsgInfomap);
}

Future createChatRoom(
    String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
  final snapShot = await FirebaseFirestore.instance
      .collection("chatroom")
      .doc(chatRoomId)
      .get();

  if (snapShot.exists) {
    return true;
  } else {
    return FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .set(chatRoomInfoMap);
  }
}

Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
  return await FirebaseFirestore.instance
      .collection("chatroom")
      .doc(chatRoomId)
      .collection("chats")
      .orderBy("ts")
      .snapshots();

  //return true;
}

var loginUser = FirebaseAuth.instance.currentUser;

getCurrentUser() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    loginUser = user;
  }
}

Future getUserData() async {
  List itemsList = [];
  try {
    await bb.get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        itemsList.add(element.data);
      });
    });
    return itemsList;
  } catch (e) {}
}
