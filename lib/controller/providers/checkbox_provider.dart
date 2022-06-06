

import 'package:flutter/cupertino.dart';

class TermsProvider with ChangeNotifier{
  bool checkBox = false;
  selectedValue(bool val){
    checkBox=val;
    notifyListeners();
  }
}