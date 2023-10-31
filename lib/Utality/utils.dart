import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void focuschange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static void fluashbarshow(dynamic message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message.toString(),
        backgroundColor: Colors.red.withOpacity(0.9),
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.error),
        duration: Duration(seconds: 3),
        forwardAnimationCurve: Curves.easeIn,
        reverseAnimationCurve: Curves.easeOut,
        borderRadius: BorderRadius.circular(20),
        // positionOffset: 80.0,
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context),
    );
  }

  static toastMessage(String message) {
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.deepPurple.withOpacity(0.6),
    );
  }
}
