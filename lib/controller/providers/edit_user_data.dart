import 'package:flutter/cupertino.dart';

class EditProvider with ChangeNotifier {
  bool read = true;

  readAndWrite(){
    read=!read;
    notifyListeners();
  }
}
