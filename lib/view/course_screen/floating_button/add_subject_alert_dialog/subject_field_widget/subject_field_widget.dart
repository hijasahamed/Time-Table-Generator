import 'package:flutter/material.dart';
import 'package:time_table/model/text_widget_model.dart';

class SubjectFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Size screenSize;

  const SubjectFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: label,
          color: Colors.blueGrey,
          size: screenSize.width / 25,
          fontFamily: '',
          weight: FontWeight.w600,
        ),
        SizedBox(height: screenSize.height / 100),
        TextField(
          controller: controller,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenSize.width / 75),
            ),
            hintText: 'Enter $label',
            hintStyle: TextStyle(color: Colors.grey[400]),
          ),
        ),
      ],
    );
  }
}