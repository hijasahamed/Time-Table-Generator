import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_table/controller/home_screen_controller.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/course_screen/floating_button/add_subject_alert_dialog/alert_close_button/alert_close_button.dart';
import 'package:time_table/view/home_screen/bloc/home_screen_bloc.dart';

void showAlertDialogForDataAdding({
  required BuildContext context,
  required bool isAddCourse,
  required bool isAddStaff,
  required Size screenSize,
  required String staffName,
  required List subjects,
  required bool isEditStaff,
  required String docId,
  required bool isEditCourse,
  required bool edit
}) {
  final TextEditingController textController = TextEditingController();

  HomeScreenBloc homeScreenBloc = HomeScreenBloc();
  final List<String> selectedSubjects = [];
  HomeScreenBloc refreshStateBloc = HomeScreenBloc();

  if(isEditStaff==true){
    textController.text=staffName;
    selectedSubjects.addAll((subjects).cast<String>());
  }
  else if(isEditCourse == true){
    textController.text = staffName;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenSize.width / 25),
        ),
        title: TitleWidget(
          isAddCourse: isAddCourse,
          screenSize: screenSize,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: 'Enter ${isAddCourse ? 'Course' : 'Staff'} Name',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: screenSize.width / 25,
                  ),
                  border: const OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: screenSize.height / 30),
              if (isAddStaff)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(text: 'SELECT THE SUBJECTS', color: Colors.blueGrey, size: screenSize.width/30, fontFamily: '', weight: FontWeight.w500),                    
                    Container(
                      height: screenSize.height / 2,
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(screenSize.width/75),
                        border: Border.all(width: .2,color: Colors.grey)
                      ),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('subjects')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
          
                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: TextWidget(
                                text: 'No Subjects Available',
                                color: Colors.grey,
                                size: screenSize.width / 25,
                                fontFamily: '',
                                weight: FontWeight.w500,
                              ),
                            );
                          }
          
                          final Set<String> uniqueSubjects = {};
          
                          for (var doc in snapshot.data!.docs) {
                            Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;
                            uniqueSubjects
                                .addAll(data.values.whereType<String>());
                          }
          
                          return ListView(
                            children: uniqueSubjects.map((subject) {
                              return BlocBuilder<HomeScreenBloc, HomeScreenState>(
                                bloc: refreshStateBloc,
                                builder: (context, state) {
                                  return CheckboxListTile(
                                    title: Text(subject),
                                    value: selectedSubjects.contains(subject),
                                    onChanged: (isSelected) {
                                      if (isSelected == true) {
                                        selectedSubjects.add(subject);
                                        refreshStateBloc.add(
                                            RefreshSelectSubjectScreenEvent());
                                      } else {
                                        selectedSubjects.remove(subject);
                                        refreshStateBloc.add(
                                            RefreshSelectSubjectScreenEvent());
                                      }
                                    },
                                  );
                                },
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: screenSize.height / 30),
                  ],
                ),
              AddDataToDb(
                textController: textController,
                homeScreenBloc: homeScreenBloc,
                selectedSubjects: selectedSubjects,
                isAddCourse: isAddCourse,
                isAddStaff: isAddStaff,
                screenSize: screenSize,
                docId: docId,
                isEditStaff: isEditStaff,
                edit: edit,
                isEditCourse: isEditCourse,
              )
            ],
          ),
        ),
      );
    },
  );
}

class AddDataToDb extends StatelessWidget {
  const AddDataToDb(
      {super.key,
      required this.textController,
      required this.homeScreenBloc,
      required this.selectedSubjects,
      required this.isAddCourse,
      required this.isAddStaff,
      required this.isEditStaff,
      required this.docId,
      required this.screenSize,
      required this.edit,
      required this.isEditCourse
      });

  final TextEditingController textController;
  final HomeScreenBloc homeScreenBloc;
  final List<String> selectedSubjects;
  final bool isAddCourse;
  final bool isAddStaff;
  final Size screenSize;
  final bool isEditStaff;
  final String docId;
  final bool edit;
  final bool isEditCourse;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        addDataToFirebase(
          isAddCourse: isAddCourse,
          isAddStaff: isAddStaff,
          textController: textController,
          context: context,
          homeScreenBloc: homeScreenBloc,
          isEditStaff: isEditStaff,
          selectedSubjects: selectedSubjects,
          docId: docId,
          isEditCourse: isEditCourse,
        );            
      },
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenSize.width / 75),
            color: const Color.fromARGB(255, 238, 238, 238),
            border: Border.all(color: Colors.grey, width: .5)),
        height: screenSize.height / 17,
        width: screenSize.width,
        child: Center(
            child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          bloc: homeScreenBloc,
          builder: (context, state) {
            return state is AddingButtonCircularIndicatorState
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                      strokeWidth: 2.5,
                    ),
                  )
                : state is AddingButtonCircularIndicatorStopState
                    ? AddButtonText(
                        isAddCourse: isAddCourse, screenSize: screenSize,edit: edit,)
                    : AddButtonText(
                        isAddCourse: isAddCourse,
                        screenSize: screenSize,
                        edit: edit,
                      );
          },
        )),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget(
      {super.key, required this.isAddCourse, required this.screenSize});
  final Size screenSize;
  final bool isAddCourse;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextWidget(
            text: isAddCourse ? 'Add New Course' : 'Add New Staff',
            color: Colors.blueGrey,
            size: screenSize.width / 17,
            fontFamily: '',
            weight: FontWeight.w600),
        const Spacer(),
        AlertCloseButton(
          screenSize: screenSize,
        )
      ],
    );
  }
}

class AddButtonText extends StatelessWidget {
  const AddButtonText(
      {super.key, required this.isAddCourse, required this.screenSize,required this.edit});
  final Size screenSize;
  final bool isAddCourse;
  final bool edit;
  
  @override
  Widget build(BuildContext context) {
    return TextWidget(
        text: edit ? 'Update' : 'Add',
        color: Colors.green,
        size: screenSize.width / 28,
        fontFamily: '',
        weight: FontWeight.w400);
  }
}
