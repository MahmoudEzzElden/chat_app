import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/providers/user_image.dart';

class ProfileImage extends StatelessWidget {
 final File? image;
 final Function()? onTap;
  const ProfileImage({Key? key, this.image, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,
      child: CircleAvatar(
        backgroundImage:image==null
            ? AssetImage("assets/default.jpg") as ImageProvider :
        FileImage(
            image!),
        radius: 80,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
