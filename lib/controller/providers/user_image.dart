import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImageHandler with ChangeNotifier{
File? selectedImage;
Future pickGalleryImage() async{
final image=await ImagePicker().pickImage(source: ImageSource.gallery);
final image2=File(image!.path);
selectedImage=image2;
notifyListeners();
}
Future pickCameraImage() async{
  final image=await ImagePicker().pickImage(source: ImageSource.camera);
  final image2=File(image!.path);
  selectedImage=image2;
  notifyListeners();
}
}