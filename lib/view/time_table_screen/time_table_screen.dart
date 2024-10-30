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
        title: 'Time Table',
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
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(day, style: const TextStyle(fontSize: 20, color: Colors.white)),
                      const SizedBox(height: 5),
                      Column(
                        children: List.generate(periods.length, (i) {
                          return Row(
                            children: [
                              Text(
                                'Period ${i + 1}: ',
                                style: const TextStyle(fontSize: 16, color: Colors.white70),
                              ),
                              Text(
                                periods[i],
                                style: const TextStyle(fontSize: 16, color: Colors.white),
                              ),
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