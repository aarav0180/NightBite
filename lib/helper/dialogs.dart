import 'package:flutter/material.dart';

class Dialogs{
  static void showSnackbar(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg,style: TextStyle(fontWeight: FontWeight.bold),),
      backgroundColor: Colors.blueAccent.withOpacity(.7),
      behavior: SnackBarBehavior.floating ,));
  }

  static void showProgressLoader(BuildContext context){
    showDialog(context: context, builder: (_)=>Center(child:CircularProgressIndicator()));
    //Center wrapped otherwise it will cover whole screen
  }
}