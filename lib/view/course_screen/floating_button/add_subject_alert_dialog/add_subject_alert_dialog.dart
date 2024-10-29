import 'package:flutter/material.dart';
import 'package:time_table/controller/course_screen_controller.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/course_screen/floating_button/add_subject_alert_dialog/alert_close_button/alert_close_button.dart';
import 'package:time_table/view/course_screen/floating_button/add_subject_alert_dialog/subject_field_widget/subject_field_widget.dart';

void showAddSubjectsDialog(
    {required BuildContext context,
    required Size screenSize,
    required String courseName}) {
  final TextEditingController subject1Controller = TextEditingController();
  final TextEditingController subject2Controller = TextEditingController();
  final TextEditingController subject3Controller = TextEditingController();
  final TextEditingController subject4Controller = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenSize.width / 50),
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            TextWidget(
              text: 'ADD SUBJECTS',
              color: Colors.blueGrey,
              size: screenSize.width / 20,
              fontFamily: '',
              weight: FontWeight.bold,
            ),
            const Spacer(),
            AlertCloseButton(screenSize: screenSize,)
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SubjectFieldWidget(
                  label: 'Subject 1',
                  controller: subject1Controller,
                  screenSize: screenSize),
              SizedBox(height: screenSize.height / 50),
              SubjectFieldWidget(
                  label: 'Subject 2',
                  controller: subject2Controller,
                  screenSize: screenSize),
              SizedBox(height: screenSize.height / 50),
              SubjectFieldWidget(
                  label: 'Subject 3',
                  controller: subject3Controller,
                  screenSize: screenSize),
              SizedBox(height: screenSize.height / 50),
              SubjectFieldWidget(
                  label: 'Subject 4',
                  controller: subject4Controller,
                  screenSize: screenSize),
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              addSubjectsToFirestore(
                  courseName: courseName,
                  sub1Controller: subject1Controller,
                  sub2Controller: subject2Controller,
                  sub3Controller: subject3Controller,
                  sub4Controller: subject4Controller,
                  context: context).then((value) {
                    Navigator.of(context).pop();
                  },);
            },
            child: Ink(
              width: screenSize.width,
              height: screenSize.height / 18,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenSize.width / 75),
                  border: Border.all(width: .5, color: Colors.grey)),
              child: Center(
                child: TextWidget(
                  text: 'ADD SUBJECT',
                  color: Colors.green,
                  size: screenSize.width / 25,
                  fontFamily: '',
                  weight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      );
    },
  );
}

