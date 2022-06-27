import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miniflutter/model/chat_room_model.dart';
import 'package:miniflutter/model/constants.dart';
import 'package:miniflutter/services/firebase_auth.dart';



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
    ChatRoomModel chat = ModalRoute.of(context)!.settings.arguments as ChatRoomModel;

    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context,true);
       return Future.value(true);
      },
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.green,
          title:Row(
            children: [
              CachedNetworkImage(
                imageUrl:chat.profilePic!,
                imageBuilder: (context, imageProvider) => Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Container(
                  color: Colors.black,
                  child: const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 10,),
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
                     padding: const EdgeInsets.symmetric(vertical: 10),
                     itemCount: snapshot.data!.docs.length,
                       reverse: true,
                       itemBuilder: (context,index){

                      return
                        snapshot.data!.docs[index][sentBy] ==chat.firstUserID?
                            Bubble(
                              elevation: 5,
                              color: Colors.greenAccent,
                              alignment: Alignment.topRight ,
                              stick: true,
                              nip: BubbleNip.rightTop,
                              margin: const BubbleEdges.only(top: 10),
                              child: Text(snapshot.data!.docs[index][messageContent],textAlign: TextAlign.end,style: const TextStyle(fontSize: 15),),
                            )
                        : Bubble(
                          elevation: 5,
                          color: Colors.lightBlue,
                          alignment: Alignment.topLeft ,
                          stick: true,
                          nip: BubbleNip.leftBottom,
                          margin: const BubbleEdges.only(top: 10),
                          child: Text(snapshot.data!.docs[index][messageContent],textAlign: TextAlign.start,style: const TextStyle(fontSize: 15),),
                        );
                       }):const Center(child: Text('No Messages yet'),)
                   : snapshot.hasError?
                   Center(child: Text(snapshot.error.toString()),) : const Center(child: CircularProgressIndicator(),);
               }),
         ),


//
        Row(

        children: [
          const SizedBox(width: 10,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
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
                      decoration: const InputDecoration(
                          hintText: "Type Something...",
                          hintStyle: TextStyle( color:     Colors.blueAccent),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
                color: Colors.blueAccent, shape: BoxShape.circle),
            child: GestureDetector(
              child: const Icon(
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

      ),
    );
  }
}
