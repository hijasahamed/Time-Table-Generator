import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/course_screen/floating_button/add_subject_alert_dialog/add_subject_alert_dialog.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton(
      {super.key, required this.screenSize, required this.courseName});

  final Size screenSize;
  final String courseName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showAddSubjectsDialog(context: context, screenSize: screenSize,courseName: courseName);
      },
      customBorder: const CircleBorder(),
      splashColor: Colors.white.withOpacity(0.2),
      child: Ink(
        width: screenSize.width / 5,
        height: screenSize.width / 5,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: TextWidget(
            text: 'Add Subjects',
            color: Colors.white,
            size: screenSize.width / 35,
            fontFamily: '',
            weight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
