// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> deleteStaff({required String docId,required BuildContext context}) async {
  try {
    await FirebaseFirestore.instance.collection('staff').doc(docId).delete();
    Navigator.of(context).pop();
    
  } catch (e) {
    log(e.toString());
  }
}
