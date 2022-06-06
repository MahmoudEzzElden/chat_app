import 'package:flutter/cupertino.dart';
import 'package:miniflutter/services/firebase_auth.dart';

class FirebaseProvider with ChangeNotifier{
  getMessages(String chatRoomId){
    notifyListeners();
   return FireBaseService.getAllMessages(chatRoomId);

  }
  sendMessages(){

  }

}
