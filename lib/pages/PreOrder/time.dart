import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

/* void main() {
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
      home: const PreOrderPage(orderMethod: 'Pre-Order'),
    );
  }
} */

class PreOrderPage extends StatefulWidget {
  final String orderMethod;
  final ValueNotifier<String> selectedTimeNotifier;
  const PreOrderPage({super.key, required this.orderMethod, required this.selectedTimeNotifier});

  @override
  State<StatefulWidget> createState() => _PreOrderPageState();
}

class _PreOrderPageState extends State<PreOrderPage> {
  late String preOrderTime;
  late String deliveryTime;
  String time = '';
  String selectedOption = 'None';
  //String currentTime = '';

  @override
  void initState() {
    super.initState();
    preOrderTime = _getInitialTime();
    deliveryTime = _getInitialTime();
    time = _getInitialTime();
  }

  String _getInitialTime() {
    return DateFormat('hh:mm a').format(DateTime.now());
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

  String formatTime(TimeOfDay time) {
    final dateTime = DateTime(2022, 1, 1, time.hour, time.minute);
    final dateFormat = DateFormat('hh:mm a');
    return dateFormat.format(dateTime);
  }

  Future<void> _selectTime(BuildContext context, String option) async {
    try {
      final currentWorldTime = await _getCurrentWorldTime();
      final TimeOfDay? picked = await showTimePick();

      if (picked != null) {
        final DateTime selectedDateTime = DateTime(
          currentWorldTime.year, currentWorldTime.month, currentWorldTime.day,
          picked.hour, picked.minute,
        );

        if (selectedDateTime.isAfter(currentWorldTime)) {
          setState(() {
            if (option == 'Order Now') {
              selectedOption = 'Order Now';
            } else if (option == 'Pre-order') {
              time = formatTime(picked);
              selectedOption = 'Pre-order';
              //updateTime(time);
            } else if (option == 'Delivery') {
              time = formatTime(picked);
              selectedOption = 'Delivery';
              //updateTime(time);
            }
          });

          // Automatically estimate automation time based on the selected time
          _estimateAutomationTime(option);
        } else {
          showInvalidTimeError();
        }
      }
    } catch (e) {
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to load current world time.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<TimeOfDay?> showTimePick() async {
    return await showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  void showInvalidTimeError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Time'),
          content: const Text('Please select a time after the current time.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      }
    );
  }

  // Function to estimate automation time based on the selected time
  void _estimateAutomationTime(String option) {
    //String selectedTime = (option == 'Pre-order') ? preOrderTime : (option == 'Delivery') ? deliveryTime : '';
    String estimatedAutomationTime = "Estimated Automation Time for $option: $time";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Automation Time Estimate'),
          content: Text(estimatedAutomationTime),
          actions: [
            TextButton(
              // Pass the selected time back to the payment page
              onPressed: () => Navigator.pop(context, time),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pre-order and Automation Time',
          style: TextStyle(color: Colors.black)
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            //print(time);
            Navigator.pop(context, time);
            //Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /* Center(
              child: ElevatedButton(
                onPressed: () {
                  _selectTime(context, 'Order Now');
                },
                child: const Text('Order Now'),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16), */
            if (widget.orderMethod == 'Pre-Order') ...[
              const Text(
                'Select Pre-order Time:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedOption == 'None' || selectedOption == 'Pre-order') {
                      _selectTime(context, 'Pre-order');
                    } else {
                      showOneOptionOnlyMessage();
                    }
                  },
                  child: const Text('Select Time'),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Pre-order Time: $time',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ]
            else ...[
              const Text(
                'Select Delivery Time:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedOption == 'None' || selectedOption == 'Delivery') {
                      _selectTime(context, 'Delivery');
                    } else {
                      showOneOptionOnlyMessage();
                    }
                  },
                  child: const Text('Select Time'),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Delivery Time: $deliveryTime',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
            ],
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void showOneOptionOnlyMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('You can only choose one option.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      }
    );
  }
}