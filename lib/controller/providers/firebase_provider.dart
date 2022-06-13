// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:miniflutter/services/firebase_auth.dart';
//
// import '../../model/constants.dart';
//
// class FirebaseProvider with ChangeNotifier {
//   getUser() {
//     notifyListeners();
//     return  FirebaseFirestore.instance
//         .collection(usersCollection)
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .snapshots();
//   }
// }
