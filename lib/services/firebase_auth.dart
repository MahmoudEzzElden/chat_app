import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniflutter/view/screens/HomePage.dart';

import '../model/user_model.dart';

class FireBaseService {
  static Future register(BuildContext context, String email, String password,
      String userName,
      String age, String gender) async {
    try {
      EasyLoading.show(status: 'Registering...');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        FirebaseFirestore.instance.collection('Users').doc(uid).set({

          'User Name': userName,
          'User ID': uid,
          'Age': age,
          'Gender': gender,
        });
        EasyLoading.showSuccess("Successfully Registered");
        Navigator.pop(context);
        EasyLoading.dismiss();
      });
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Registration Failed'),
              content: Text('${e.message}'),
            ),
      );
    }
  }

  static Future userUpdate(BuildContext context,
      String userName, String age, String gender) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    EasyLoading.show(status: 'Updating...');
    await FirebaseFirestore.instance.collection('Users').doc(uid).update({
      'User Name': userName,
      'User ID': uid,
      'Age': age,
      'Gender': gender,
    }).then((value) {
      EasyLoading.showSuccess('Successfully Edited');
    });
    EasyLoading.dismiss();
  }

  static Future signIn(BuildContext context, email, String password) async {
    try {
      EasyLoading.show(status: 'Signing in...');
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      EasyLoading.showSuccess('Great Success');
      await Navigator.pushNamed(context, HomePage.routeName);
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
EasyLoading.showError(e.message.toString(),duration: Duration(seconds: 4));
EasyLoading.dismiss();
    }
  }

  static getAllUsers(){
    String id=FirebaseAuth.instance.currentUser!.uid;
     return FirebaseFirestore.instance.collection('Users').where("User ID",isNotEqualTo:id ).snapshots();
  }

  static  getAllMessages(String chatRoomId){
    return FirebaseFirestore.instance.collection('ChatRooms').doc(chatRoomId).collection(chatRoomId).orderBy('Create Time',descending: true).snapshots();
  }

static Future createChatRoom(String chatRoomId) async{
    String createdChatRoomId='';
  List option2 = chatRoomId.split('_');

  String chatRoomId2 = '${option2[1]}_${option2[0]}';
  final result= await FirebaseFirestore.instance.collection('ChatRooms').get();
  final list= await result.docs.where((element){
    print(element.id);
    return (element.id==chatRoomId||element.id==chatRoomId2);
  }
  );

  if(list.isEmpty){

    print('list is empty');
    FirebaseFirestore.instance.collection('ChatRooms').doc(chatRoomId).set(
        {'0':'1'});
    createdChatRoomId=chatRoomId;
    return createdChatRoomId;
  }
  else if(list.first.id==chatRoomId){
    print('there is a document with this id ');
    createdChatRoomId = chatRoomId;
    return createdChatRoomId;
  }
  else if(list.first.id==chatRoomId2){
    print('there is a document with a reversed id ');
    createdChatRoomId=chatRoomId2;
    return createdChatRoomId;
  }
}

  static Future sendMessage(String chatRoomId, String message,
      String senderId) async {
      return await FirebaseFirestore.instance.collection('ChatRooms').doc(chatRoomId).collection(chatRoomId).doc().set(
          {
            'Message':message,
            'SentBy':senderId,
            'Create Time':DateTime.now()
          });
  }
}
