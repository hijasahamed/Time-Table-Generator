import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        icon: const Icon(Icons.more_vert, color: Colors.white),
        onSelected: (value) {
          if (value == 'delete') {
            confirmStaffDelete(context: context, staffName: staffName, docId: doc.id, screenSize: screenSize);
          } else if (value == 'edit') {
            
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, color: Colors.black54),
                SizedBox(width: 8),
                Text('Edit'),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, color: Colors.black54),
                SizedBox(width: 8),
                Text('Delete'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}