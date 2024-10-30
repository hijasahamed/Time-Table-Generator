// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_table/model/snackbar_widget.dart';


Future<bool> doesCourseExist({required String courseName}) async {
  DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
      .collection('subjects')
      .doc(courseName)
      .get();
  return docSnapshot.exists;
}


// Function to add the subjects of the Course to firebase 
Future<void> addSubjectsToFirestore(
    {required String courseName,
    required TextEditingController sub1Controller,
    required TextEditingController sub2Controller,
    required TextEditingController sub3Controller,
    required TextEditingController sub4Controller,
    required BuildContext context}) async {
  try {
    if (sub1Controller.text.isNotEmpty &&
        sub2Controller.text.isNotEmpty &&
        sub3Controller.text.isNotEmpty &&
        sub4Controller.text.isNotEmpty) {
      Map<String, String> subjectsData = {
        'sub1': sub1Controller.text.trim(),
        'sub2': sub2Controller.text.trim(),
        'sub3': sub3Controller.text.trim(),
        'sub4': sub4Controller.text.trim(),
      };

      final collectionRef = FirebaseFirestore.instance.collection('subjects');

      await collectionRef.doc(courseName).set(subjectsData);
      snackbarMessageWidget(
          text: 'Subjects Added',
          context: context,
          color: Colors.green,
          textColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          time: 3000);
    } else {
      snackbarMessageWidget(
          text: 'ADD ALL SUBJECTS',
          context: context,
          color: Colors.red,
          textColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          time: 3000);
    }
  } catch (e) {
    log(e.toString());
  }
}