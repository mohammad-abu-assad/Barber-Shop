import 'package:flutter/material.dart';
import 'customTimePickerDialog.dart';

class TimeChooserField extends StatefulWidget {
  final TimeOfDay? openingTime;
  final TimeOfDay? closingTime;
  final String? labelText;

  TimeChooserField({this.openingTime, this.closingTime, this.labelText});

  @override
  _TimeChooserFieldState createState() => _TimeChooserFieldState();
}

class _TimeChooserFieldState extends State<TimeChooserField> {
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 70, // Fixed width for the label column
            child: Text(
              widget.labelText! + ':',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              readOnly: true,
              controller: _timeController,
              onTap: () async {
                final selected = await _openTimePickerDialog(context);
                if (selected != null) {
                  setState(() {
                    _timeController.text = selected.format(context);
                  });
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                hintText: 'Click here to choose time',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<TimeOfDay?> _openTimePickerDialog(BuildContext context) async {
    final selected = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return CustomTimePickerDialog(
          openingTime: widget.openingTime,
          closingTime: widget.closingTime,
        );
      },
    );
    return selected;
  }
}

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

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: MainPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                _openFilterSheet(context);
              },
              child: Text(
                'Filter',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openFilterSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Column(
          children: [
            SizedBox(height: 10), // Spacer at the top
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  color: Colors.grey, // Drag handle
                ),
              ],
            ),
            Expanded(
              child: FilterPage(),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Icon(
                    Icons.keyboard_arrow_down, // Down arrow icon
                    color: Colors.grey,
                    size: 20,
                  ),
                  Text(
                    'Swipe down to close', // Hint for users to close the sheet
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
