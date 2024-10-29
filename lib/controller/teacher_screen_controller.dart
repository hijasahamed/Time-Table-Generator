// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_table/model/snackbar_widget.dart';

Future<void> deleteStaff({required String docId,required BuildContext context}) async {
  try {
    await FirebaseFirestore.instance.collection('staff').doc(docId).delete();
    snackbarMessageWidget(text: 'Staff Removed', context: context, color: Colors.green, textColor: Colors.white, behavior:SnackBarBehavior.floating, time: 3000);
  } catch (e) {
    log(e.toString());
  }
}
