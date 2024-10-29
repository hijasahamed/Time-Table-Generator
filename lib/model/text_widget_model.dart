import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.text,
      required this.color,
      this.maxline,
      required this.size,
      required this.fontFamily,
      this.alignTextCenter,
      required this.weight});
  final String text;
  final Color color;
  final double size;
  final bool? maxline;
  final FontWeight weight;
  final String fontFamily;
  final bool? alignTextCenter;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: weight,
        color: color,
        fontSize: size,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: (maxline==true)? 10 :1,
      textAlign: (alignTextCenter==true)?TextAlign.center:TextAlign.left,
    );
  }
}