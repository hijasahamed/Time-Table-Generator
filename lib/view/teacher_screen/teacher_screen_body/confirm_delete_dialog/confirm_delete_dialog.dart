import 'package:flutter/material.dart';
import 'package:time_table/controller/teacher_screen_controller.dart';
import 'package:time_table/model/text_widget_model.dart';

void confirmStaffDelete({required BuildContext context,required String staffName,required String docId,required Size screenSize}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[850],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              text: 'Are you sure you want to delete',
              color: Colors.white,
              size: screenSize.width / 25,
              fontFamily: '',
              weight: FontWeight.normal,
            ),
            const SizedBox(height: 8),
            TextWidget(
              text: staffName,
              color: Colors.white,
              size: screenSize.width / 25,
              fontFamily: '',
              weight: FontWeight.bold,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextWidget(
              text: 'No',
              color: Colors.white,
              size: screenSize.width / 25,
              fontFamily: '',
              weight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {             
              deleteStaff(docId: docId).then((value) {
                Navigator.of(context).pop();
              },);
            },
            child: TextWidget(
              text: 'Yes',
              color: Colors.white,
              size: screenSize.width / 25,
              fontFamily: '',
              weight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }