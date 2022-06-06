import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniflutter/controller/providers/firebase_provider.dart';
import 'package:miniflutter/model/chat_room_model.dart';
import 'package:miniflutter/services/firebase_auth.dart';
import 'package:provider/provider.dart';

class ChatRoom extends StatefulWidget {
  static const routeName = 'ChatRoom';

  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController message = TextEditingController();


  @override
  void dispose() {
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     // Map map = ModalRoute.of(context)?.settings.arguments as Map;
    ChatRoomModel chat = ModalRoute.of(context)!.settings.arguments as ChatRoomModel;

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,
        title:Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xff4c505b),
              child: Text(chat.secondUserName.toString()[0].toUpperCase()),
            ),
            SizedBox(width: 10,),
            Text(chat.secondUserName!),
          ],

        ),
      ),
      body: Column(
       children: [
       Expanded(
         child: StreamBuilder<QuerySnapshot>(
           stream:FireBaseService.getAllMessages(chat.chatRoomId!),
             builder: (context,snapshot){
             return snapshot.hasData?
             snapshot.requireData.docs.isNotEmpty?
                 ListView.builder(
                   scrollDirection: Axis.vertical,
                   shrinkWrap: true,
                   padding: EdgeInsets.symmetric(vertical: 10),
                   itemCount: snapshot.data!.docs.length,
                     reverse: true,
                     itemBuilder: (context,index){

                    return
                      snapshot.data!.docs[index]['SentBy'] ==chat.firstUserID?
                          Bubble(
                            elevation: 5,
                            color: Colors.greenAccent,
                            alignment: Alignment.topRight ,
                            stick: true,
                            nip: BubbleNip.rightTop,
                            margin: BubbleEdges.only(top: 10),
                            child: Text(snapshot.data!.docs[index]['Message'],textAlign: TextAlign.end,style: TextStyle(fontSize: 15),),
                          )
                      : Bubble(
                        elevation: 5,
                        color: Colors.lightBlue,
                        alignment: Alignment.topLeft ,
                        stick: true,
                        nip: BubbleNip.leftBottom,
                        margin: BubbleEdges.only(top: 10),
                        child: Text(snapshot.data!.docs[index]['Message'],textAlign: TextAlign.start,style: TextStyle(fontSize: 15),),
                      );
                     }):Center(child: Text('No Messages yet'),)
                 : snapshot.hasError?
                 Center(child: Text(snapshot.error.toString()),) : Center(child: CircularProgressIndicator(),);
             }),
       ),


//
      Row(

      children: [
        SizedBox(width: 10,),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3),
                    blurRadius: 5,
                    color: Colors.grey)
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: message,
                    decoration: InputDecoration(
                        hintText: "Type Something...",
                        hintStyle: TextStyle( color:     Colors.blueAccent),
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 15),
        Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Colors.blueAccent, shape: BoxShape.circle),
          child: GestureDetector(
            child: Icon(
              Icons.send_rounded,
              color: Colors.white,
            ),
          onTap: (){
              FireBaseService.sendMessage(chat.chatRoomId!, message.text, chat.firstUserID!);
              message.clear();
          },
          ),
        )
      ],
      ),

       //
       ],
            ),

    );
  }
}
