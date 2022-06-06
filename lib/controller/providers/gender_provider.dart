import 'package:flutter/cupertino.dart';

class GenderProvider with ChangeNotifier{
  String? genderValue;
  List genderList = ['Male', 'Female'];
  selectedGender(String g){
    genderValue=g;
    notifyListeners();
  }
}