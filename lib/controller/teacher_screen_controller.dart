import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteStaff({required String docId}) async {
  try {
    await FirebaseFirestore.instance.collection('staff').doc(docId).delete();
  } catch (e) {
    log(e.toString());
  }
}
