import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_table/controller/home_screen_controller.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/home_screen/bloc/home_screen_bloc.dart';

void showAlertDialogForDataAdding({
  required BuildContext context,
  required bool isAddCourse,
  required bool isAddStaff,
  required Size screenSize,
}) {
  final TextEditingController textController = TextEditingController();
  HomeScreenBloc homeScreenBloc = HomeScreenBloc();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenSize.width / 25),
        ),
        title: Row(
          children: [
            TextWidget(
                text: isAddCourse ? 'Add New Course' : 'Add New Staff',
                color: Colors.blueGrey,
                size: screenSize.width / 17,
                fontFamily: '',
                weight: FontWeight.w600),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close,size: screenSize.width/12,))
          ],
        ),
        content: Column(
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
            InkWell(
              onTap: () async {
                addDataToFirebase(
                    isAddCourse: isAddCourse,
                    isAddStaff: isAddStaff,
                    textController: textController,
                    context: context,
                    homeScreenBloc: homeScreenBloc
                  )
                    .then(
                  (value) {
                    Navigator.of(context).pop();
                  },
                );
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenSize.width / 75),
                  color: const Color.fromARGB(255, 238, 238, 238),
                  border: Border.all(color: Colors.grey,width: .5)
                ),
                height: screenSize.height / 17,
                width: screenSize.width,
                child: Center(
                  child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                  bloc: homeScreenBloc,
                  builder: (context, state) {                   
                    return state is AddingButtonCircularIndicatorState?
                     const Center(
                      child: CircularProgressIndicator(color: Colors.green,strokeWidth: 2.5,),
                    )
                    : state is AddingButtonCircularIndicatorStopState? AddButtonText(isAddCourse: isAddCourse, screenSize: screenSize)
                    : AddButtonText(isAddCourse: isAddCourse,screenSize: screenSize,);
                  },
                )),
              ),
            )
          ],
        ),
      );
    },
  );
}

class AddButtonText extends StatelessWidget {
  const AddButtonText({
    super.key,
    required this.isAddCourse,
    required this.screenSize
  });
  final Size screenSize;
  final bool isAddCourse;
  @override
  Widget build(BuildContext context) {
    return TextWidget(
      text: isAddCourse ? 'Add New Course' : 'Add New Staff',
      color: Colors.green,
      size: screenSize.width / 28,
      fontFamily: '',
      weight: FontWeight.w400
    );
  }
}
