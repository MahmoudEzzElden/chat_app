

import 'package:flutter/cupertino.dart';

class SocialStateProvider with ChangeNotifier{
  int radioValue = 0;
selectedValue(int val){
  radioValue = val;
  notifyListeners();
}
}