import 'package:flutter/material.dart';
import 'package:time_table/view/home_screen/app_bar_widget/app_bar_widget.dart';
import 'package:time_table/view/home_screen/body_widget/body_widget.dart';
import 'package:time_table/view/home_screen/bottom_app_bar_widget/bottom_app_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key,required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: HomeScreenAppBarWidget(screenSize: screenSize),
      body: HomeScreenBodyWidget(screenSize: screenSize,),
      bottomNavigationBar: HomeScreenBottomAppBarWidget(screenSize: screenSize),
    );
  }
}