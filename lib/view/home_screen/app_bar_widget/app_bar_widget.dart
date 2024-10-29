import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';

class HomeScreenAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBarWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      title: TextWidget(text: 'Time Table Generator', color: Colors.white, size: screenSize.width/18, fontFamily: '', weight: FontWeight.w600),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(screenSize.height/11);
}