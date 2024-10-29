import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';

class HomeScreenAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBarWidget({
    super.key,
    required this.screenSize,
    required this.title,
    this.isBack,
    this.isHomeScreen
  });

  final Size screenSize;
  final String title;
  final bool? isBack;
  final bool? isHomeScreen;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      
      automaticallyImplyLeading: false,
      leading: (isBack == true)? IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        }, 
        icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)
      ):(isHomeScreen == true)?  IconButton(
        onPressed: () {
          
        }, 
        icon: const Icon(Icons.person,color: Colors.white,)
      ):null, 
      backgroundColor: Colors.black,
      title: TextWidget(text: title, color: Colors.white, size: screenSize.width/18, fontFamily: '', weight: FontWeight.w600),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(screenSize.height/11);
}