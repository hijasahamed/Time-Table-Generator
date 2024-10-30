import 'package:flutter/material.dart';
import 'package:time_table/view/home_screen/app_bar_widget/app_bar_widget.dart';

class TimeTableScreen extends StatelessWidget {
  const TimeTableScreen({super.key,required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: HomeScreenAppBarWidget(screenSize: screenSize, title: 'Time Table',isBack: true,),
    );
  }
}