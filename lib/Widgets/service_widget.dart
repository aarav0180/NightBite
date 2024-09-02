import 'dart:ui';

import 'package:flutter/material.dart';

class AppWidget{
  static TextStyle boldTextfieldStyle(){
    return TextStyle(
        color: Colors.black,
        fontSize: 35.0,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle lightTextStyle() {
    return TextStyle (
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w500
    );
  }

  static TextStyle semiBoldTextStyle(){
    return TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22.0
    );
  }
}