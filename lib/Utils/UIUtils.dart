
import 'package:flutter/material.dart';

class UIUtils{
  static void displayDialog({
    @required BuildContext context,
    @required String title,
    @required String message} ) {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(title),
            content: Text(message),
          );
        }
    );
  }

}