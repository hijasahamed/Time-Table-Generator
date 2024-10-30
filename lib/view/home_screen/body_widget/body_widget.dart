import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/home_screen/body_widget/course_details_grid_holder/course_details_grid_holder.dart';

class HomeScreenBodyWidget extends StatelessWidget {
  const HomeScreenBodyWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('courses').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.blue,));
        }
        if (snapshot.hasError) {
          return Center(
            child: TextWidget(
              text: 'No courses available',
              color: Colors.white,
              size: screenSize.width / 16,
              fontFamily: '',
              weight: FontWeight.bold,
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: TextWidget(
              text: 'No courses available',
              color: Colors.white,
              size: screenSize.width / 16,
              fontFamily: '',
              weight: FontWeight.bold,
            ),
          );
        }
        final courses = snapshot.data!.docs;
        return CourseDetailsGridHolder(screenSize: screenSize, courses: courses);
      },
    );
  }
}