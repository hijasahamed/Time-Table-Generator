import 'package:flutter/material.dart';

snackbarMessageWidget({required String text, required context, required Color color, required Color textColor, required SnackBarBehavior behavior,required int time}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    dismissDirection: DismissDirection.horizontal,
    duration: Duration(milliseconds: time),
    behavior: behavior,
    backgroundColor: color,    
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: textColor, fontWeight: FontWeight.w500,fontFamily: 'FarmDairyFontNormal'),
    ),
  ));
}