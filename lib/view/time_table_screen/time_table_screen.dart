import 'package:flutter/material.dart';
import 'package:time_table/view/home_screen/app_bar_widget/app_bar_widget.dart';

class TimeTableScreen extends StatelessWidget {
  const TimeTableScreen({super.key,required this.screenSize,required this.courseName});
  final Size screenSize;
  final String courseName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: HomeScreenAppBarWidget(screenSize: screenSize, title: 'Time Table',isBack: true,),
    );
  }
}