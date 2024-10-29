import 'package:flutter/material.dart';
import 'package:time_table/view/home_screen/app_bar_widget/app_bar_widget.dart';
import 'package:time_table/view/teacher_screen/teacher_screen_body/teacher_screen_body.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key,required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: HomeScreenAppBarWidget(screenSize: screenSize, title: 'Teachers',isBack: true,),
      body: TeacherScreenBodyWidget(screenSize: screenSize),
    );
  }
}



 