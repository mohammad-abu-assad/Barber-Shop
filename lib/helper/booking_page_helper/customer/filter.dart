import 'package:flutter/material.dart';
import 'package:myfirstapp/helper/timeChooserField.dart';

class FilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Filter Options',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Select Time:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TimeChooserField(
              labelText: 'After',
              openingTime: TimeOfDay(hour: 15, minute: 30),
              closingTime: TimeOfDay(hour: 22, minute: 0),
            ),
            SizedBox(height: 10),
            TimeChooserField(
              labelText: 'Before',
              openingTime: TimeOfDay(hour: 0, minute: 0),
              closingTime: TimeOfDay(hour: 15, minute: 0),
            ),
            Divider(),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                Text('Facial Treatment'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Apply changes logic
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey, // Button background color
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Rounded corners
                ),
                elevation: 10, // Shadow elevation
              ),
              child: Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
