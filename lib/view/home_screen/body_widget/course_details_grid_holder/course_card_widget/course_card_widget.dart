import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/home_screen/body_widget/course_details_grid_holder/course_card_widget/course_name_widget/course_name_widget.dart';
import 'package:time_table/view/home_screen/bottom_app_bar_widget/add_button_widget/show_alert_dialog/show_alert_dialog.dart';
import 'package:time_table/view/teacher_screen/teacher_screen_body/confirm_delete_dialog/confirm_delete_dialog.dart';

class CourseCardWidget extends StatelessWidget {
  const CourseCardWidget({
    super.key,
    required this.screenSize,
    required this.courseName,
    required this.docId
  });

  final Size screenSize;
  final dynamic courseName;
  final String docId;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenSize.width / 40),
      ),
      shadowColor: Colors.black54,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenSize.width / 40),
          gradient: const LinearGradient(
            colors: [Color(0xFF6a11cb), Color(0xFF2575fc)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(          
          children: [
            CourseNameWidget(screenSize: screenSize, courseName: courseName),
            Positioned(
              top: 2,
              right: 2,
              child: PopupMenuButton<String>(
                color: Colors.white,
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onSelected: (value) {
                  if (value == 'delete') {
                    confirmStaffAndCourseDelete(context: context, staffName: '', docId: docId, screenSize: screenSize,courseName: courseName,isCourseDelete: true);
                  } else if (value == 'edit') {
                    showAlertDialogForDataAdding(
                      context: context,
                      isAddCourse: true,
                      isAddStaff: false,
                      isEditStaff: false,
                      staffName: courseName,
                      subjects:  [],
                      screenSize: screenSize,
                      docId: docId,
                      isEditCourse: true,
                      edit: true
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
            )
          ],
        ),
      ),
    );
  }
}

