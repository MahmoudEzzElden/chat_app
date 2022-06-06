

import 'package:miniflutter/model/constants.dart';

class ChatRoomModel{


  final String? firstUserID;
  final String? secondUserID;
  final String? secondUserName;
  final String? chatRoomId;


  const ChatRoomModel({this.firstUserID, this.secondUserID, this.secondUserName,this.chatRoomId});

  Map<String,dynamic> toMap(){
    return {firstId: firstUserID,
      secondId:secondUserID,
      secondUsersName:secondUserName,
      chatRoomID:chatRoomId,
    };
  }
//
  factory ChatRoomModel.fromMap(Map<String,dynamic> map){
    return ChatRoomModel(
      firstUserID:map[firstId],
      secondUserID:map[secondId],
      secondUserName:map[secondUsersName],
      chatRoomId: chatRoomID,

    );
  }




}