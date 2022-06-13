import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:miniflutter/view/custom_widgets/custom_button.dart';
import 'package:miniflutter/view/custom_widgets/profile_image.dart';
import 'package:provider/provider.dart';

import '../../controller/providers/user_image.dart';
import '../../model/constants.dart';
import '../../services/firebase_storage.dart';

class ImageEdit extends StatelessWidget {
  static const String routeName = 'ImageEdit';

  const ImageEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Edit Profile Pic'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            ProfileImage(
              image: Provider.of<ImageHandler>(context).selectedImage,
            ),
            SizedBox(
              height: 40,
            ),
            Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  width: 20.0,
                  height: 50.0,
                  text: 'Pick From Gallery',
                  onPressed: () {

                    Provider.of<ImageHandler>(context, listen: false)
                        .pickGalleryImage();
                  },
                ),
                CustomElevatedButton(
                  width: 10.0,
                  height: 50.0,
                  text: 'Pick From Camera',
                  onPressed: () {
                    Provider.of<ImageHandler>(context, listen: false)
                        .pickCameraImage();
                  },
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          FirebaseStorage.instance
              .ref('usersImages/${FirebaseAuth.instance.currentUser!.uid}')
              .delete();
          FireStorage.uploadImage(
                  Provider.of<ImageHandler>(context, listen: false)
                      .selectedImage!
                      .path,
                  FirebaseAuth.instance.currentUser!.uid).whenComplete(() async {
            await FirebaseFirestore.instance.collection(usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).update({
              profilePic: await FirebaseStorage.instance.ref('usersImages/${FirebaseAuth.instance.currentUser!.uid}').getDownloadURL()
            });
          })
              .whenComplete(() => Navigator.pop(context));
        },
      ),
    );
  }
}
