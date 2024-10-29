import 'package:flutter/material.dart';
import 'package:time_table/view/home_screen/bottom_app_bar_widget/add_button_widget/add_button_widget.dart';

class HomeScreenBottomAppBarWidget extends StatelessWidget {
  const HomeScreenBottomAppBarWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        children: [
          AddButtonWidget(screenSize: screenSize,isAddCourse: true,isAddStaff: false,),
          SizedBox(width: screenSize.width/60,),
          AddButtonWidget(screenSize: screenSize, isAddCourse: false, isAddStaff: true)
        ],
      ),
    );
  }
}

