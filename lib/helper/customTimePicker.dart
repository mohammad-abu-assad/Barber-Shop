import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomTimePicker extends StatefulWidget {
  final TimeOfDay? openingTime;
  final TimeOfDay? closingTime;

  CustomTimePicker({
    this.openingTime,
    this.closingTime,
  });

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late int selectedHour;
  late int selectedMinute;

  void _initializeSelectedTime() {
    selectedHour = widget.openingTime?.hour ?? 8;
    selectedMinute = widget.openingTime?.minute ?? 0;
  }

  @override
  void initState() {
    super.initState();
    _initializeSelectedTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: NumberPicker(
                  value: selectedHour,
                  minValue: widget.openingTime?.hour ?? 0,
                  maxValue: widget.closingTime?.hour ?? 23,
                  onChanged: (value) {
                    setState(() {
                      selectedHour = value;
                    });
                  },
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
              Text(' hours', style: TextStyle(color: Colors.white)),
              SizedBox(width: 20),
              Flexible(
                child: NumberPicker(
                  value: selectedMinute,
                  minValue: 0,
                  maxValue: 59,
                  onChanged: (value) {
                    setState(() {
                      selectedMinute = value;
                    });
                  },
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
              Text(' minutes', style: TextStyle(color: Colors.white)),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              final selectedTime =
                  TimeOfDay(hour: selectedHour, minute: selectedMinute);

              if (widget.openingTime == null || widget.closingTime == null) {
                _showErrorDialog('Invalid Time Range');
                return;
              }

              if (selectedTime.hour >= widget.openingTime!.hour &&
                  selectedTime.hour <= widget.closingTime!.hour) {
                if (selectedTime.hour == widget.closingTime!.hour &&
                    selectedTime.minute > widget.closingTime!.minute) {
                  _showErrorDialog('Invalid Time');
                } else {
                  if (selectedTime.hour == widget.openingTime!.hour &&
                      selectedTime.minute < widget.openingTime!.minute) {
                    _showErrorDialog('Invalid Time');
                  } else {
                    Navigator.of(context)
                        .pop(selectedTime); // Return the selected time
                  }
                }
              } else {
                _showErrorDialog('Invalid Time Range');
              }
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
