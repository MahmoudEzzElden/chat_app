import 'package:flutter/material.dart';

InputDecoration? decorationText({
  Color textColor = Colors.blue,
  double textSize = 14,
  String? hintText,
  FloatingLabelBehavior? floatingLabelBehavior,
  required String labelText,
  required IconData prefixIcon ,

}) =>
    InputDecoration(
      // fillColor: Colors.grey.shade100,
      // filled: true,
      floatingLabelBehavior: floatingLabelBehavior,
      prefixIcon: Icon(prefixIcon),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(color: textColor, fontSize: textSize),
      enabledBorder:OutlineInputBorder(
        borderRadius:BorderRadius.circular(10),
        borderSide: BorderSide(
            color: Colors.black
        ),

      ),
      focusedErrorBorder:OutlineInputBorder(
        borderRadius:BorderRadius.circular(10),
        borderSide: BorderSide(
            color: Colors.red
        ),

      ),
      focusedBorder:OutlineInputBorder(
        borderRadius:BorderRadius.circular(10),
        borderSide: BorderSide(
            color: Colors.blueGrey
        ),

      ),
      errorBorder:OutlineInputBorder(
        borderRadius:BorderRadius.circular(10),
        borderSide: BorderSide(
            color: Colors.red
        ),
      ),
        disabledBorder:OutlineInputBorder(
          borderRadius:BorderRadius.circular(10),
          borderSide: BorderSide(
              color: Colors.blueGrey
          ),
        ),
    );