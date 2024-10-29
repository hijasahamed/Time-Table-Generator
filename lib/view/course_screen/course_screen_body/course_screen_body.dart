import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/course_screen/course_screen_body/course_subject_widget/course_subject_widget.dart';

class CourseScreenBody extends StatelessWidget {
  const CourseScreenBody({
    super.key,
    required this.screenSize,
    required this.courseName
  });

  final Size screenSize;
  final String courseName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenSize.width/75),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: 'SUBJECTS', color: Colors.white, size: screenSize.width/20, fontFamily: '', weight: FontWeight.bold),
            SizedBox(height: screenSize.height / 40),
            CourseSubjectWidget(courseName: courseName, screenSize: screenSize),
          ],
        ),
      ),
    );
  }
}