import 'package:flutter/material.dart';

class Appointment {
  late String day;
  late TimeOfDay startTime;
  late bool facialTreatment;

  Appointment(
      {required this.day,
      required this.startTime,
      required this.facialTreatment});

  // Calculate the duration of the appointment based on whether facial treatment is included
  Duration get duration {
    if (facialTreatment) {
      return Duration(hours: 1);
    } else {
      return Duration(minutes: 30);
    }
  }
}
