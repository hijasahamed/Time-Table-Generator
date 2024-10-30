import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';

class TeacherDetailsWidget extends StatelessWidget {
  const TeacherDetailsWidget({
    super.key,
    required this.screenSize,
    required this.staffName,
    required this.subjects,
  });

  final Size screenSize;
  final dynamic staffName;
  final List<String> subjects;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenSize.width/75),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextWidget(text: staffName, color: Colors.white, size: screenSize.width/25, fontFamily: '', weight: FontWeight.bold),
          SizedBox(height: screenSize.height/50),
          TextWidget(text: 'Subjects:', color: Colors.white ,size: screenSize.width/30, fontFamily: '', weight: FontWeight.bold),
          SizedBox(height: screenSize.height/100),                        
          ...subjects.map((subject) => TextWidget(text: '- $subject', color: Colors.white, size: screenSize.width/31, fontFamily: '', weight: FontWeight.bold)),
        ],
      ),
    );
  }
}