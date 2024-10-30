import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_table/view/teacher_screen/teacher_screen_body/popupmenu_button_widget/popupmenu_button_widget.dart';
import 'package:time_table/view/teacher_screen/teacher_screen_body/teacher_details_widget/teacher_details_widget.dart';

class TeachersDetailsGridCardWidget extends StatelessWidget {
  const TeachersDetailsGridCardWidget({
    super.key,
    required this.screenSize,
    required this.staffDocs,
  });

  final Size screenSize;
  final List<QueryDocumentSnapshot<Object?>> staffDocs;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: screenSize.width / 25,
        mainAxisSpacing: screenSize.height / 40,
        childAspectRatio: 4 / 3,
      ),
      itemCount: staffDocs.length,
      itemBuilder: (context, index) {
        final doc = staffDocs[index];
        final staffName = doc['staffName'] ?? 'No Name';
        final subjects = List<String>.from(doc['subjects'] ?? []);
        
        return Container(
          margin: EdgeInsets.all(screenSize.width/75),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenSize.width / 40),
            gradient: const LinearGradient(
              colors: [Color(0xFF6a11cb), Color(0xFF2575fc)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              TeacherDetailsWidget(screenSize: screenSize, staffName: staffName, subjects: subjects),
              PopUpMenuButtonWidget(staffName: staffName, doc: doc, screenSize: screenSize),                
            ],
          ),
        );
      },
    );
  }
}