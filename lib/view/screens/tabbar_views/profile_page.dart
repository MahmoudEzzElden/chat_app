//import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:miniflutter/controller/providers/edit_user_data.dart';
import 'package:miniflutter/controller/providers/firebase_provider.dart';
import 'package:miniflutter/model/constants.dart';
import 'package:miniflutter/services/firebase_auth.dart';
import 'package:miniflutter/services/firebase_storage.dart';
import 'package:miniflutter/view/custom_widgets/custom_button.dart';
import 'package:miniflutter/view/custom_widgets/profile_image.dart';
import 'package:miniflutter/view/screens/profile_image_edit.dart';
import 'package:provider/provider.dart';
import '../../../controller/providers/user_image.dart';
import '../../../model/user_model.dart';
import '../../styles/input_decoration.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  final userName = TextEditingController();

  final age = TextEditingController();

  final gender = TextEditingController();

  final formKey = GlobalKey<FormState>();




  @override
  void dispose() {
    userName.dispose();
    age.dispose();
    gender.dispose();
    EasyLoading.dismiss();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream:
            FirebaseFirestore.instance
                .collection(usersCollection)
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapShot) {

              var userDoc = snapShot.data;

              return snapShot.hasData
                  ? Column(
                    children: [
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, ImageEdit.routeName);
                        },
                        child:
                        CircleAvatar(
                          backgroundImage: NetworkImage(

                             (userDoc as DocumentSnapshot)[profilePic]
                          ),
                          radius: 70,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          readOnly: Provider
                              .of<EditProvider>(context)
                              .read,
                          controller: userName,
                          decoration: decorationText(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Name',
                            hintText:
                            (userDoc as DocumentSnapshot)[usersName],
                            prefixIcon: Icons.person,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 20, right: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          readOnly: Provider
                              .of<EditProvider>(context)
                              .read,
                          controller: age,
                          decoration: decorationText(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Age',
                            hintText: (userDoc as DocumentSnapshot)[usersAge],
                            prefixIcon: Icons.person,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          readOnly: Provider
                              .of<EditProvider>(context)
                              .read,
                          controller: gender,
                          decoration: decorationText(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Gender',
                            hintText: (userDoc as DocumentSnapshot)[usersGender],
                            prefixIcon: Icons.person,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomElevatedButton(
                              width: 150.0,
                              height: 50.0,
                              text: 'Edit',
                              onPressed: () {
                                Provider.of<EditProvider>(context,
                                    listen: false)
                                    .readAndWrite();
                              }),
                          CustomElevatedButton(
                              width: 150.0,
                              height: 50.0,
                              text: 'Save',
                              onPressed: () {
                                    FireBaseService.userUpdate(
                                        context,
                                        userName.text.isEmpty? (userDoc as DocumentSnapshot)[usersName]: userName.text,
                                        age.text.isEmpty? (userDoc as DocumentSnapshot)[usersAge]: age.text,
                                        gender.text.isEmpty? (userDoc as DocumentSnapshot)[usersGender]: gender.text);
                                    Provider.of<EditProvider>(context,
                                        listen: false)
                                        .readAndWrite();
                              }),
                        ],
                      )
                    ],
                  )
                  : snapShot.hasError
                  ? Text('Error Happened')
                  :Center(child: CircularProgressIndicator(),);
            },
          ),
        ),
      ),
    );
  }
}
