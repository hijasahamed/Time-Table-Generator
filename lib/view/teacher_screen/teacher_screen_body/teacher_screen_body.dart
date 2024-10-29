import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/teacher_screen/teacher_screen_body/confirm_delete_dialog/confirm_delete_dialog.dart';

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
                  Padding(
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
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () => confirmStaffDelete(context: context, staffName: staffName, docId: doc.id, screenSize: screenSize)
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}