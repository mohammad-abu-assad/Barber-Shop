import 'package:flutter/material.dart';
import 'customTimePicker.dart';

class CustomTimePickerDialog extends StatelessWidget {
  final TimeOfDay? openingTime;
  final TimeOfDay? closingTime;

  CustomTimePickerDialog({
    this.openingTime,
    this.closingTime,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      content: CustomTimePicker(
        openingTime: openingTime,
        closingTime: closingTime,
      ),
    );
  }
}
