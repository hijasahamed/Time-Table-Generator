// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_table/model/snackbar_widget.dart';
import 'package:time_table/view/home_screen/bloc/home_screen_bloc.dart';



Future<void> addDataToFirebase({
  required bool isAddCourse,
  required bool isAddStaff,
  required TextEditingController textController,
  required BuildContext context,
  required HomeScreenBloc homeScreenBloc
  }) async {
  String collectionName = isAddCourse ? 'courses' : 'staff';
  if (collectionName.isNotEmpty&& textController.text.isNotEmpty) {
    homeScreenBloc.add(AddingButtonCircularIndicatorEvent());
    await FirebaseFirestore.instance.collection(collectionName).add({
      'name': textController.text,
      'createdAt': Timestamp.now(),
    });
    homeScreenBloc.add(AddingButtonCircularIndicatorStopEvent());
    snackbarMessageWidget(text: isAddCourse ? 'Course Added' : 'Staff Added', context: context, color: Colors.green, textColor: Colors.white, behavior: SnackBarBehavior.floating, time: 3000);
  }
  else{
    snackbarMessageWidget(text: 'Enter a valid data', context: context, color: Colors.red, textColor: Colors.white, behavior: SnackBarBehavior.floating, time: 3000);
  }
}