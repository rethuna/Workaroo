import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

 void kShowToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xff014c92),
      textColor: Colors.white,
      fontSize: 16.0);
}
