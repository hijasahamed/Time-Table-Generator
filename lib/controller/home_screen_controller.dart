// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_table/model/snackbar_widget.dart';
import 'package:time_table/view/home_screen/bloc/home_screen_bloc.dart';
import 'package:time_table/view/teacher_screen/bloc/teachers_screen_bloc.dart';


Future<void> addDataToFirebase({
  required bool isAddCourse,
  required bool isAddStaff,
  required TextEditingController textController,
  required BuildContext context,
  required HomeScreenBloc homeScreenBloc,
  required List selectedSubjects,
  required bool isEditStaff,
  required String docId
  }) async {
  String collectionName = isAddCourse ? 'courses' : 'staff';
  if (collectionName.isNotEmpty && textController.text.isNotEmpty) {
    homeScreenBloc.add(AddingButtonCircularIndicatorEvent());
    if(collectionName == 'courses'){
      await FirebaseFirestore.instance.collection(collectionName).add({
        'name': textController.text,
        'createdAt': Timestamp.now(),      
      });
      snackbarMessageWidget(text:  'Course Added' , context: context, color: Colors.green, textColor: Colors.white, behavior: SnackBarBehavior.floating, time: 3000);
      Navigator.of(context).pop();
    }
    else if(isEditStaff == true ){
      await FirebaseFirestore.instance.collection(collectionName).doc(docId).update({
        'staffName': textController.text,
        'subjects': selectedSubjects,
      });
      snackbarMessageWidget(text: 'Staff Updated', context: context, color: Colors.green, textColor: Colors.white, behavior: SnackBarBehavior.floating, time: 3000);
      Navigator.of(context).pop();
    }
    else{
      if(selectedSubjects.isNotEmpty){
        await FirebaseFirestore.instance.collection(collectionName).add({
          'staffName': textController.text,
          'createdAt': Timestamp.now(),
          'subjects' : selectedSubjects,      
        });
        snackbarMessageWidget(text: 'Staff Added', context: context, color: Colors.green, textColor: Colors.white, behavior: SnackBarBehavior.floating, time: 3000);
        Navigator.of(context).pop();
      }else{
        snackbarMessageWidget(text: 'Select Subjects', context: context, color: Colors.red, textColor: Colors.white, behavior: SnackBarBehavior.floating, time: 3000);
      }      
    }
    homeScreenBloc.add(AddingButtonCircularIndicatorStopEvent());    
  }
  else{
    snackbarMessageWidget(text: 'Enter a valid data', context: context, color: Colors.red, textColor: Colors.white, behavior: SnackBarBehavior.floating, time: 3000);
  }
}


Future<void> deleteCourse({required String docId,required BuildContext context,required TeachersScreenBloc teachersScreenBloc}) async {
  try {
    teachersScreenBloc.add(DeleteTeacherCircularIndicatorEvent());
    await FirebaseFirestore.instance.collection('courses').doc(docId).delete();
    teachersScreenBloc.add(DeleteTeacherCircularIndicatorStopEvent());
    snackbarMessageWidget(
    text: 'Course Removed',
    context: context,
    color: Colors.green,
    textColor: Colors.white,
    behavior: SnackBarBehavior.floating,
    time: 3000);
    Navigator.of(context).pop();    
  } catch (e) {
    log(e.toString());
  }
}