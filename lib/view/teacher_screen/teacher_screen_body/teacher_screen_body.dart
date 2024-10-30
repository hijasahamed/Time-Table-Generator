import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/teacher_screen/teacher_screen_body/teachers_details_grid_card_widget/teachers_details_grid_card_widget.dart';

class TeacherScreenBodyWidget extends StatelessWidget {
  const TeacherScreenBodyWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('staff').orderBy('createdAt').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.white,));
        }
        if (snapshot.hasError) {
          return Center(child: TextWidget(text: 'Error loading data', color: Colors.white, size: screenSize.width/20, fontFamily: '', weight: FontWeight.w300));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: TextWidget(text: 'No staff data available', color: Colors.white, size: screenSize.width/20, fontFamily: '', weight: FontWeight.w300));
        }
    
        final staffDocs = snapshot.data!.docs;
    
        return TeachersDetailsGridCardWidget(screenSize: screenSize, staffDocs: staffDocs);
      },
    );
  }
}





