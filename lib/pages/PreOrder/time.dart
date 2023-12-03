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
  const PreOrderPage({super.key});

  @override
  State<StatefulWidget> createState() => _PreOrderPageState();
}

class _PreOrderPageState extends State<PreOrderPage> {
  late String preOrderTime;
  late String deliveryTime;
  String selectedOption = 'None';

  @override
  void initState() {
    super.initState();
    preOrderTime = _getInitialTime();
    deliveryTime = _getInitialTime();
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

  Future<void> _selectTime(BuildContext context, String option) async {
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
            if (option == 'Order Now') {
              selectedOption = 'Order Now';
            } else if (option == 'Pre-order') {
              preOrderTime = "${picked.hour}:${picked.minute} ${picked.period.toString().split('.')[1]}";
              selectedOption = 'Pre-order';
            } else if (option == 'Delivery') {
              deliveryTime = "${picked.hour}:${picked.minute} ${picked.period.toString().split('.')[1]}";
              selectedOption = 'Delivery';
            }
          });

          // Automatically estimate automation time based on the selected time
          _estimateAutomationTime(option);
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Invalid Time'),
                content: const Text('Please select a time after the current time.'),
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

  // Function to estimate automation time based on the selected time
  void _estimateAutomationTime(String option) {
    String selectedTime = (option == 'Pre-order') ? preOrderTime : (option == 'Delivery') ? deliveryTime : '';
    String estimatedAutomationTime = "Estimated Automation Time for $option: $selectedTime";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Automation Time Estimate'),
          content: Text(estimatedAutomationTime),
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
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _selectTime(context, 'Order Now');
                },
                child: const Text('Order Now'),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('You can only choose one option.'),
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
                },
                child: const Text('Select Time'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Pre-order Time: $preOrderTime',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('You can only choose one option.'),
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
                },
                child: const Text('Select Time'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Delivery Time: $deliveryTime',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}