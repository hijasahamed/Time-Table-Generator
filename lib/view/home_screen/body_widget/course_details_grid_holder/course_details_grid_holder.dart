import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_table/view/course_screen/course_screen.dart';
import 'package:time_table/view/home_screen/body_widget/course_details_grid_holder/course_card_widget/course_card_widget.dart';

class CourseDetailsGridHolder extends StatelessWidget {
  const CourseDetailsGridHolder({
    super.key,
    required this.screenSize,
    required this.courses,
  });

  final Size screenSize;
  final List<QueryDocumentSnapshot<Object?>> courses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width / 80),
      child: GridView.builder(
        padding: EdgeInsets.only(top: screenSize.height / 80),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: courses.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: screenSize.width / 25,
          mainAxisSpacing: screenSize.height / 40,
          childAspectRatio: 4 / 3,
        ),
        itemBuilder: (context, index) {
          final DocumentSnapshot courseSnapshot = courses[index];
          final courseName = courseSnapshot['name'] ?? 'Unnamed Course';
          final docId = courseSnapshot.id;
    
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CourseScreen(courseName: courseName,screenSize: screenSize,);
              },));
            },
            child: CourseCardWidget(screenSize: screenSize, courseName: courseName,docId: docId,),
          );
        },
      ),
    );
  }
}

