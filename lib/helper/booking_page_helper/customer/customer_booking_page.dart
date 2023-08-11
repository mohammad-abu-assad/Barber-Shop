import 'package:flutter/material.dart';
import 'dart:core';
import 'package:myfirstapp/classes/appointment.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Map<String, List<Appointment>> appointmentsMap = {};

  Week selectedWeek = Week.A;
  bool showDays = false;
  List<Appointment> availableAppointments = [];

  Map<Week, String> weekOpeningHours = {
    Week.A: '15:30 - 22:00',
    Week.B: '14:30 - 21:00',
    Week.C: '10:00 - 12:30',
  };

  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  int currentDayIndex = DateTime.now().weekday - 1;

  void _showBookingBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Book an Appointment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Opening Hours: ${weekOpeningHours[selectedWeek]}',
                style: const TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showDays = true;
                    availableAppointments = calculateAvailableAppointments();
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Book Now'),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Appointment> calculateAvailableAppointments() {
    // Calculate available appointments based on existing appointments
    List<Appointment> existingAppointments =
        appointmentsMap[daysOfWeek[currentDayIndex]]!;
    List<Appointment> availableAppointments = [];

    // Assuming each appointment takes 30 minutes
    int totalAppointments = 13; // Adjusted for appointments from 15:30 to 21:30
    TimeOfDay currentTime = TimeOfDay(hour: 15, minute: 30);
    TimeOfDay closingTime = TimeOfDay(hour: 21, minute: 30);
    int res = compareTimeOfDay(currentTime, closingTime);
    int i = 0;
    while (res < 0) {
      if (i < existingAppointments.length) {
        TimeOfDay tmp = existingAppointments[i].startTime;
        while (compareTimeOfDay(currentTime, tmp) < 0) {
          availableAppointments.add(Appointment(
              day: daysOfWeek[currentDayIndex],
              startTime: currentTime,
              facialTreatment: false));
        }
      }
    }
    for (int i = 0; i < totalAppointments; i++) {
      //bool isAvailable = true;
      String startTime =
          '${15 + i ~/ 2}:${i % 2 == 0 ? '30' : '00'}'; // Adjusted time format

      for (Appointment appointment in existingAppointments) {
        if (appointment.startTime == startTime) {
          //isAvailable = false;
          break;
        }
      }
    }

    return availableAppointments;
  }

  int compareTimeOfDay(TimeOfDay time1, TimeOfDay time2) {
    final int minutes1 = time1.hour * 60 + time1.minute;
    final int minutes2 = time2.hour * 60 + time2.minute;

    if (minutes1 < minutes2) {
      return -1;
    } else if (minutes1 > minutes2) {
      return 1;
    } else {
      return 0;
    }
  }

  bool isAvailable() {
    return true;
  }

  @override
  void initState() {
    super.initState();

    for (String day in daysOfWeek) {
      appointmentsMap[day] = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!showDays)
                ElevatedButton(
                  onPressed: _showBookingBottomSheet,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Book an Appointment'),
                ),
              if (showDays)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      daysOfWeek.length,
                      (index) => ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentDayIndex =
                                index; // Update the current day index
                            availableAppointments =
                                calculateAvailableAppointments();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: currentDayIndex == index
                              ? Colors.blue // Highlight the selected day
                              : Colors.grey,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(daysOfWeek[index]),
                      ),
                    ),
                  ),
                ),
              if (showDays)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: availableAppointments
                          .map(
                            (appointment) => Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Text(
                                  'Day: ${appointment.day}\nTime: ${appointment.startTime}',
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    // Handle appointment booking
                                  },
                                  child: const Text('Book'),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

enum Week { A, B, C }

void main() {
  runApp(const MaterialApp(
    home: BookingPage(),
  ));
}
