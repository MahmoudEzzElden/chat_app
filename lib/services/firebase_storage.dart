

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FireStorage{
 static Future uploadImage(String imagePath,String imageName) async {
    File imageFile=File(imagePath);
    try{
      EasyLoading.show(status: 'Uploading Image...');
     await FirebaseStorage.instance.ref('usersImages/$imageName').putFile(imageFile);
     EasyLoading.dismiss();
    } on FirebaseException catch(e){
      EasyLoading.showError(e.message!,duration: Duration(seconds: 4));
      EasyLoading.dismiss();
    }
  }

}