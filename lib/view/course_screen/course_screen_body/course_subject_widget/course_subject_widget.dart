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
              child: Padding(
                padding: EdgeInsets.all(screenSize.width/60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,                
                  children: [
                    TextWidget(
                      text: subject,
                      color: Colors.white,
                      size: screenSize.width / 20,
                      fontFamily: '',
                      weight: FontWeight.bold,
                    ),
                    TeachingStaffName(screenSize: screenSize, subject: subject),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class TeachingStaffName extends StatelessWidget {
  const TeachingStaffName({
    super.key,
    required this.screenSize,
    required this.subject,
  });

  final Size screenSize;
  final String subject;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('staff').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
    
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: TextWidget(
                  text: 'No Staff Found',
                  color: Colors.grey,
                  size: screenSize.width / 25,
                  fontFamily: '',
                  weight: FontWeight.w500,
                ),
              );
            }
    

            List<String> staffNames = [];
            for (var doc in snapshot.data!.docs) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              List<dynamic> subjects = data['subjects'] ?? [];
              
              if (subjects.contains(subject)) {
                staffNames.add(data['staffName'] ?? 'No Name');
              }
            }
    

            if (staffNames.isEmpty) {
              return TextWidget(
                text: 'No Staff Teaching This Subject',
                color: Colors.red,
                size: screenSize.width / 30,
                fontFamily: '',
                weight: FontWeight.w500,
              );
            }
    
            return Column(
              children: staffNames.map((name) => TextWidget(
                text: 'Teacher : $name',
                color: Colors.green,
                size: screenSize.width / 30,
                fontFamily: '',
                weight: FontWeight.bold,
              )).toList(),
            );
          },
        );
  }
}