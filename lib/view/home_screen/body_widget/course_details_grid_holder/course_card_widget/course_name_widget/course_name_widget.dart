import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';

class CourseNameWidget extends StatelessWidget {
  const CourseNameWidget({
    super.key,
    required this.screenSize,
    required this.courseName,
  });

  final Size screenSize;
  final String courseName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width / 80),
        child: TextWidget(
          text: courseName,
          color: Colors.white,
          size: screenSize.width / 28,
          fontFamily: '',
          weight: FontWeight.bold,
          maxline: true,
          alignTextCenter: true,
        ),
      ),
    );
  }
}