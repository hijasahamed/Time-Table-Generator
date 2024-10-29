import 'package:flutter/material.dart';

class AlertCloseButton extends StatelessWidget {
  const AlertCloseButton({
    super.key,
    required this.screenSize
  });
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close,size: screenSize.width/12,)),
      ],
    );
  }
}