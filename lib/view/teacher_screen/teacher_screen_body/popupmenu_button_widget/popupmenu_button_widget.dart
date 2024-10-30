import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/home_screen/bottom_app_bar_widget/add_button_widget/show_alert_dialog/show_alert_dialog.dart';
import 'package:time_table/view/teacher_screen/teacher_screen_body/confirm_delete_dialog/confirm_delete_dialog.dart';

class PopUpMenuButtonWidget extends StatelessWidget {
  const PopUpMenuButtonWidget({
    super.key,
    required this.staffName,
    required this.doc,
    required this.screenSize,
  });

  final dynamic staffName;
  final QueryDocumentSnapshot<Object?> doc;
  final Size screenSize;


  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 2,
      right: 2,
      child: PopupMenuButton<String>(
        color: Colors.white,
        icon: const Icon(Icons.more_vert, color: Colors.white),
        onSelected: (value) {
          if (value == 'delete') {
            confirmStaffDelete(context: context, staffName: staffName, docId: doc.id, screenSize: screenSize);
          } else if (value == 'edit') {
            showAlertDialogForDataAdding(
              context: context,
              isAddCourse: false,
              isAddStaff: true,
              isEditStaff: true,
              staffName: staffName,
              subjects: doc['subjects'] ?? [],
              screenSize: screenSize,
              docId: doc.id
            );
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, color: Colors.blueGrey,size: screenSize.width/20,),
                SizedBox(width: screenSize.width/75),
                TextWidget(text: 'Edit', color: Colors.blueGrey, size: screenSize.width/30, fontFamily: '', weight: FontWeight.w500)
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, color: Colors.blueGrey,size: screenSize.width/20,),
                SizedBox(width: screenSize.width/75),
                TextWidget(text: 'Delete', color: Colors.blueGrey, size: screenSize.width/30, fontFamily: '', weight: FontWeight.w500)
              ],
            ),
          ),
        ],
      ),
    );
  }
}