import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miniflutter/controller/providers/firebase_provider.dart';
import 'package:miniflutter/model/chat_room_model.dart';
import 'package:miniflutter/model/user_model.dart';
import 'package:miniflutter/services/firebase_auth.dart';
import 'package:miniflutter/view/screens/chat_room.dart';
import 'package:provider/provider.dart';

class UsersChatList extends StatefulWidget {
  const UsersChatList({Key? key}) : super(key: key);

  @override
  State<UsersChatList> createState() => _UsersChatListState();
}

class _UsersChatListState extends State<UsersChatList> {
  @override
  void initState() {
    super.initState();
    FireBaseService.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FireBaseService.getAllUsers(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.requireData.size,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xff4c505b),
                          child: Text(snapshot
                              .requireData.docs[index]['User Name']
                              .toString()[0]
                              .toUpperCase()),
                        ),
                        title: Text(
                          snapshot.requireData.docs[index]['User Name'],
                        ),
                        onTap: () async {
                          //this is an edit
                          // ChatRoomModel chat=ChatRoomModel();
                          String chatRoomId =
                              '${FirebaseAuth.instance.currentUser!.uid}_${snapshot.requireData.docs[index]['User ID']}';
                          String createdChatRoomId =
                              await FireBaseService.createChatRoom(chatRoomId);
                          print(createdChatRoomId);
                          //
                          // Map map={
                          //
                          //   'firstId':FirebaseAuth.instance.currentUser!.uid,
                          //   'secondId':snapshot.requireData.docs[index]['User ID'],
                          //   'secondUserName':snapshot.requireData.docs[index]['User Name'],
                          //   'chatRoomId':createdChatRoomId
                          // };

                          Navigator.pushNamed(context, ChatRoom.routeName,
                              arguments: ChatRoomModel(
                                  firstUserID:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  secondUserID: snapshot.requireData.docs[index]
                                      ['User ID'],
                                  secondUserName: snapshot
                                      .requireData.docs[index]['User Name'],
                                  chatRoomId: createdChatRoomId)
                              // arguments: map
                              );
                        },
                      );
                    },
                  )
                : snapshot.hasError
                    ? const Text('Sorry, Error Happened')
                    : const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
