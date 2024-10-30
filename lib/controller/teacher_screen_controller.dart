// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_table/view/teacher_screen/bloc/teachers_screen_bloc.dart';

Future<void> deleteStaff({required String docId,required BuildContext context,required TeachersScreenBloc teachersScreenBloc}) async {
  try {
    teachersScreenBloc.add(DeleteTeacherCircularIndicatorEvent());
    await FirebaseFirestore.instance.collection('staff').doc(docId).delete();
    teachersScreenBloc.add(DeleteTeacherCircularIndicatorStopEvent());
    Navigator.of(context).pop();    
  } catch (e) {
    log(e.toString());
  }
}
