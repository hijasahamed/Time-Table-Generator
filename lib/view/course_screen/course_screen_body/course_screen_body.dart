import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';

class CourseScreenBody extends StatelessWidget {
  const CourseScreenBody({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenSize.width/75),
      child: Column(
        children: [
          TextWidget(text: 'SUBJECTS', color: Colors.white, size: screenSize.width/20, fontFamily: '', weight: FontWeight.bold),
          
        ],
      ),
    );
  }
}