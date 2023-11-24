import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pre-order and Automation Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PreOrderPage(),
    );
  }
}

class PreOrderPage extends StatefulWidget {
  @override
  _PreOrderPageState createState() => _PreOrderPageState();
}

class _PreOrderPageState extends State<PreOrderPage> {
  late String selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = _getInitialTime();
  }

  String _getInitialTime() {
    final now = DateTime.now();
    final nextHour = now.hour + 1;
    return '${nextHour % 12}:${now.minute} ${nextHour < 12 ? 'AM' : 'PM'}';
  }

  Future<DateTime> _getCurrentWorldTime() async {
    final response = await http.get(Uri.parse('http://worldtimeapi.org/api/ip'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final DateTime currentWorldTime = DateTime.parse(data['utc_datetime']);
      return currentWorldTime.toLocal();
    } else {
      throw Exception('Failed to load world time');
    }
  }

  Future<void> _selectPreOrderTime(BuildContext context) async {
    try {
      final currentWorldTime = await _getCurrentWorldTime();

      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (picked != null) {
        final DateTime selectedDateTime = DateTime(
          currentWorldTime.year,
          currentWorldTime.month,
          currentWorldTime.day,
          picked.hour,
          picked.minute,
        );

        if (selectedDateTime.isAfter(currentWorldTime)) {
          setState(() {
            selectedTime = "${picked.hour}:${picked.minute} ${picked.period.toString().split('.')[1]}";
          });
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Invalid Time'),
                content: Text('Please select a time after the current time.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load current world time.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pre-order and Automation Time'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             ElevatedButton(
              onPressed: () {
                (context);
              },
              child: Text('Order Now'),
            ),
            SizedBox(height: 16,),
                        Divider(),

            Text(
              'Select Pre-order Time:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _selectPreOrderTime(context);
              },
              child: Text('Select Time'),
            ),
            SizedBox(height: 16),
            Text(
              'Selected Time: $selectedTime',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implement logic to estimate automation time
                  // You can use selectedTime to calculate the automation time
                  // For example, you can add a fixed time or use a predefined formula
                  String estimatedAutomationTime = "Estimated Automation Time: $selectedTime";
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Automation Time Estimate'),
                        content: Text(estimatedAutomationTime),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Estimate Automation Time'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
