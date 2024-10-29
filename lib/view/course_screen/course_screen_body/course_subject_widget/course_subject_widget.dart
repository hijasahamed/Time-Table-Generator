import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';

class CourseSubjectWidget extends StatelessWidget {
  const CourseSubjectWidget({
    super.key,
    required this.courseName,
    required this.screenSize,
  });

  final String courseName;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('subjects')
          .doc(courseName)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.data() == null) {
          return Center(
            child: TextWidget(
              text: 'No Subjects Available',
              color: Colors.grey,
              size: screenSize.width / 25,
              fontFamily: '',
              weight: FontWeight.w500,
            ),
          );
        }

        Map<String, dynamic> subjectsData =
            snapshot.data!.data() as Map<String, dynamic>;

        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: subjectsData.length,
          itemBuilder: (context, index) {
            String key = 'sub${index + 1}';
            String subject = subjectsData[key] ?? 'No Subject';

            return Container(
              margin: EdgeInsets.symmetric(vertical: screenSize.height / 100),
              height: screenSize.height / 7,
              width: screenSize.width,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6a11cb), Color(0xFF2575fc)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(screenSize.width / 50),
              ),
              child: Center(
                child: TextWidget(
                  text: subject,
                  color: Colors.white,
                  size: screenSize.width / 20,
                  fontFamily: '',
                  weight: FontWeight.bold,
                ),
              ),
            );
          },
        );
      },
    );
  }
}