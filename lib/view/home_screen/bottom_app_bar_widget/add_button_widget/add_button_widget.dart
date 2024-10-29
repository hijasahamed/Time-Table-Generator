import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/home_screen/bottom_app_bar_widget/add_button_widget/show_alert_dialog/show_alert_dialog.dart';

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget(
      {super.key,
      required this.screenSize,
      required this.isAddCourse,
      required this.isAddStaff});

  final Size screenSize;
  final bool isAddCourse;
  final bool isAddStaff;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          showAlertDialogForDataAdding(
              context: context,
              isAddCourse: isAddCourse,
              isAddStaff: isAddStaff,
              screenSize: screenSize);
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenSize.width / 75),
            color: Colors.black87,
            border: Border.all(color: Colors.grey,)
          ),
          child: Center(
              child: TextWidget(
                  text: isAddCourse
                      ? 'Add New Course'
                      : isAddStaff
                          ? 'Add New Staff'
                          : '',
                  color: Colors.white,
                  size: screenSize.width / 28,
                  fontFamily: '',
                  weight: FontWeight.w400)),
        ),
      ),
    );
  }
}