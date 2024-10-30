import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_table/controller/home_screen_controller.dart';
import 'package:time_table/controller/teacher_screen_controller.dart';
import 'package:time_table/model/snackbar_widget.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/teacher_screen/bloc/teachers_screen_bloc.dart';

void confirmStaffAndCourseDelete(
    {required BuildContext context,
    required String staffName,
    required String docId,
    required Size screenSize,
    required String courseName,
    required bool isCourseDelete,
    }) {

  TeachersScreenBloc teachersScreenBloc = TeachersScreenBloc();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color.fromARGB(255, 36, 36, 36),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            text: 'Are you sure you want to delete the ${isCourseDelete? 'Course':'Staff'} ${isCourseDelete? courseName:staffName}',
            color: Colors.white,
            size: screenSize.width / 25,
            fontFamily: '',
            weight: FontWeight.normal,
            maxline: true,
            alignTextCenter: true,
          ),
          SizedBox(height: screenSize.width / 75),
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
            weight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: () {
            isCourseDelete? deleteCourse(docId: docId, context: context, teachersScreenBloc: teachersScreenBloc,coursename: courseName):
            deleteStaff(docId: docId, context: context,teachersScreenBloc: teachersScreenBloc).then(
              (value) {
                snackbarMessageWidget(
                    text: isCourseDelete?'Course Removed':'Staff Removed',
                    context: context,
                    color: Colors.green,
                    textColor: Colors.white,
                    behavior: SnackBarBehavior.floating,
                    time: 3000);
              },
            );
          },
          child: BlocBuilder<TeachersScreenBloc, TeachersScreenState>(
            bloc: teachersScreenBloc,
            builder: (context, state) {
              return state is DeleteTeacherCircularIndicatorState?
              const CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5,)
              : state is DeleteTeacherCircularIndicatorStopState?
              TextWidget(
                text: 'Yes',
                color: Colors.white,
                size: screenSize.width / 25,
                fontFamily: '',
                weight: FontWeight.w500,
              )
              :TextWidget(
                text: 'Yes',
                color: Colors.white,
                size: screenSize.width / 25,
                fontFamily: '',
                weight: FontWeight.w500,
              ); 
            },
          ),
        ),
      ],
    ),
  );
}
