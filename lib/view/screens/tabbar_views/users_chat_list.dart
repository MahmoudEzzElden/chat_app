import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miniflutter/controller/providers/firebase_provider.dart';
import 'package:miniflutter/model/chat_room_model.dart';
import 'package:miniflutter/model/constants.dart';
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
                ? Container(
              padding: EdgeInsets.all(20),
                  child: ListView.builder(
                      itemCount: snapshot.requireData.size,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(snapshot.requireData.docs[index][profilePic]),
                          ),
                          title: Text(
                            snapshot.requireData.docs[index][usersName],
                          ),
                          onTap: () async {
                            String chatRoomId =
                                '${FirebaseAuth.instance.currentUser!.uid}_${snapshot.requireData.docs[index][usersID]}';
                            String createdChatRoomId =
                                await FireBaseService.createChatRoom(chatRoomId);
                            print(createdChatRoomId);


                            Navigator.pushNamed(context, ChatRoom.routeName,
                                arguments: ChatRoomModel(
                                    firstUserID:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    secondUserID: snapshot.requireData.docs[index]
                                        [usersID],
                                    secondUserName: snapshot
                                        .requireData.docs[index][usersName],

                                    chatRoomId: createdChatRoomId,
                                  profilePic: snapshot.requireData.docs[index][profilePic]
                                )

                                );
                          },
                        );
                      },
                    ),
                )
                : snapshot.hasError
                    ? const Text('Sorry, Error Happened')
                    : const Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
