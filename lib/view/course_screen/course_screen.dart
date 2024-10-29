import 'package:flutter/material.dart';
import 'package:time_table/view/course_screen/course_screen_body/course_screen_body.dart';
import 'package:time_table/view/course_screen/floating_button/floating_button.dart';
import 'package:time_table/view/home_screen/app_bar_widget/app_bar_widget.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key,required this.courseName,required this.screenSize});
  final String courseName;
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: HomeScreenAppBarWidget(screenSize: screenSize,title: courseName,isBack: true,),
      body: CourseScreenBody(screenSize: screenSize),
      floatingActionButton: FloatingButton(screenSize: screenSize,courseName: courseName,)
    );
  }
}