import 'package:flutter/material.dart';
import 'package:time_table/controller/course_screen_controller.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/time_table_screen/time_table_screen.dart';

class CourseScreenBottomNavBar extends StatelessWidget {
  const CourseScreenBottomNavBar({
    super.key,
    required this.courseName,
    required this.screenSize
  });

  final String courseName;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: doesCourseExist(courseName: courseName), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }
        if (snapshot.hasData && snapshot.data == true) {
          return BottomAppBar(
            color: Colors.black,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return TimeTableScreen(screenSize: screenSize);
                },));
              },
              child: Container(
                height: screenSize.height/15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenSize.width/75),
                  border: Border.all(color: Colors.grey)
                ),
                child: Center(
                  child: TextWidget(text: 'Generate TimeTable', color: Colors.white, size: screenSize.width/25, fontFamily: '', weight: FontWeight.w500),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}