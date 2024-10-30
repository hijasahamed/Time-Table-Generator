import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/home_screen/app_bar_widget/app_bar_widget.dart';

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeTableScreen extends StatelessWidget {
  const TimeTableScreen({super.key, required this.screenSize, required this.courseName});
  
  final Size screenSize;
  final String courseName;

  Future<List<String>> fetchSubjects() async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('subjects')
        .doc(courseName)
        .get();
    
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      return [
        data['sub1'] ?? '',
        data['sub2'] ?? '',
        data['sub3'] ?? '',
        data['sub4'] ?? ''
      ];
    } else {
      return []; 
    }
  }

  List<String> shuffleSubjects(List<String> subjects) {
    final random = Random();
    List<String> shuffledSubjects = List.from(subjects);
    shuffledSubjects.shuffle(random);
    return shuffledSubjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: HomeScreenAppBarWidget(
        screenSize: screenSize,
        title: courseName,
        isBack: true,
      ),
      body: FutureBuilder<List<String>>(
        future: fetchSubjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: TextWidget(text: 'No subjects available', color: Colors.white, size: screenSize.width/25, fontFamily: '', weight: FontWeight.w500));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: TextWidget(text: 'No subjects available', color: Colors.white, size: screenSize.width/25, fontFamily: '', weight: FontWeight.w500));
          }

          List<String> subjects = snapshot.data!;
          Map<String, List<String>> timetable = {};
          List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
          
          for (var day in days) {
            timetable[day] = shuffleSubjects(subjects);
          }

          return ListView.builder(
            itemCount: days.length,
            itemBuilder: (context, index) {
              String day = days[index];
              List<String> periods = timetable[day] ?? [];

              return Card(
                color: Colors.grey[850],
                margin: EdgeInsets.symmetric(vertical: screenSize.width/75, horizontal: screenSize.width/75),
                child: Padding(
                  padding: EdgeInsets.all(screenSize.width/75),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(text: day, color: Colors.white, size: screenSize.width/18, fontFamily:'', weight: FontWeight.w400),
                      SizedBox(height: screenSize.width/120),
                      Column(
                        children: List.generate(periods.length, (value) {
                          return Row(
                            children: [
                              TextWidget(text: 'Period ${value + 1}:', color: Colors.white70, size: screenSize.width/25, fontFamily:'', weight: FontWeight.w400),
                              TextWidget(text: periods[value], color: Colors.white, size: screenSize.width/25, fontFamily:'', weight: FontWeight.w400),                                                           
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}