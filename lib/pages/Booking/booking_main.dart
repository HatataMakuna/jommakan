import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const BookSeatPage());
}

class BookSeatPage extends StatelessWidget {
  const BookSeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'book_my_seat package example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BusLayout(),
    );
  }
}

class BusLayout extends StatefulWidget {
  const BusLayout({Key? key}) : super(key: key);

  @override
  State<BusLayout> createState() => _BusLayoutState();
}

class _BusLayoutState extends State<BusLayout> {
  Set<SeatNumber> selectedSeats = {};
  Uint8List? qrCodeBytes; // Use Uint8List to store image bytes

  Future<void> generateQRCode(Set<SeatNumber> selectedSeats) async {
    final List<Map<String, Object>> seatsList = selectedSeats
    .map((seat) => {
          'text': 'Welcome To JomMakan Seating',
          // 'textStyle': TextStyle(fontWeight: FontWeight.bold),
          'rowI': seat.rowI,
          'colI': seat.colI,
        })
    .toList();

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/generate_qr'),
      // Uri.parse('http://your-flask-server-ip:5000/generate_qr'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'data': seatsList,
      }),
    );

     if (response.statusCode == 200) {
      // Assume the Flask server returns the UI information in the response
      // final Map<String, dynamic> responseData = jsonDecode(response.body);

      // Debug print the response body
      print('Server response body: ${response.body}');
      // Assume the Flask server returns the QR code image URL in the response

      final File file = File('assets/example.png');
      await file.writeAsBytes(response.bodyBytes);
      //file.readAsBytes();
      //print('Body Bytes: ${response.bodyBytes}');

      setState(() {
        qrCodeBytes = response.bodyBytes;
        
      });
    } else {
      // Handle errors
      print('Failed to generate QR code: ${response.statusCode}');
    }
  }

     
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text("Please Select Your Seat"),
            const SizedBox(height: 32),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: double.maxFinite,
                height: 500,
                child: SeatLayoutWidget(
                  onSeatStateChanged: (rowI, colI, seatState) {
                    if (seatState == SeatState.selected) {
                      selectedSeats.add(SeatNumber(rowI: rowI, colI: colI));
                    } else {
                      selectedSeats.remove(SeatNumber(rowI: rowI, colI: colI));
                    }
                    setState(() {}); // Trigger a rebuild when seats are selected/deselected
                  },
                  stateModel: const SeatLayoutStateModel(
                    rows: 10,
                    cols: 7,
                    seatSvgSize: 45,
                    pathSelectedSeat: 'assets/seat_selected.svg',
                    pathDisabledSeat: 'assets/seat_disabled.svg',
                    pathSoldSeat: 'assets/seat_sold.svg',
                    pathUnSelectedSeat: 'assets/seat_unselected.svg',
                    currentSeatsState: [
                      [
                        SeatState.disabled,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.sold,
                      ],
                      [
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                      ],
                      [
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.sold,
                        SeatState.sold,
                        SeatState.sold,
                      ],
                      [
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                      ],
                      [
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.sold,
                        SeatState.sold,
                      ],
                      [
                        SeatState.sold,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                      ],
                      [
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                      ],
                      [
                        SeatState.sold,
                        SeatState.sold,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                      ],
                      [
                        SeatState.empty,
                        SeatState.empty,
                        SeatState.empty,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.sold,
                      ],
                      [
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.sold,
                        SeatState.sold,
                        SeatState.sold,
                        SeatState.unselected,
                        SeatState.unselected,
                      ],
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        color: Colors.grey.shade700,
                      ),
                      const SizedBox(width: 2),
                      const Text('Disabled')
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        color: Colors.lightBlueAccent,
                      ),
                      const SizedBox(width: 2),
                      const Text('Sold')
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xff0FFF50))),
                      ),
                      const SizedBox(width: 2),
                      const Text('Available')
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        color: const Color(0xff0FFF50),
                      ),
                      const SizedBox(width: 2),
                      const Text('Selected by you')
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
    //         ElevatedButton(
    //   onPressed: () {
    //     // This button is removed, as we're displaying the selected seats directly
    //   },
    //   style: ButtonStyle(
    //     backgroundColor: MaterialStateProperty.resolveWith((states) => const Color(0xFFfc4c4e)),
    //   ),
    //   child: const Text('Show my selected seat numbers'),
    // ),
    const SizedBox(height: 12),
    Text(selectedSeats.join(" , ")), // Display selected seat numbers directly
    
   // Add a button to generate the QR code
            ElevatedButton(
              onPressed: () {
                print("Selected Seats: $selectedSeats"); // Debug print
                generateQRCode(selectedSeats);
                print(selectedSeats);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) => const Color(0xFFfc4c4e)),
              ),
              child: const Text('Generate QR Code'),
            ),
          const SizedBox(height: 20),
            // Display the QR code using QrImage
            if (qrCodeBytes != null)
              Image.memory(
                qrCodeBytes!,
                width: 200.0,
                height: 200.0,
              ),
          ],
          ),
        ),
      ),
    );
  }
}


class UIPage extends StatelessWidget {
  final String logoUrl;
  final String welcomeText;

  const UIPage({
    required this.logoUrl,
    required this.welcomeText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Display Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              logoUrl,
              width: 100.0,
              height: 100.0,
            ),
            const SizedBox(height: 20),
            Text(
              welcomeText,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedSeatsPage extends StatelessWidget {
  final Set<SeatNumber> selectedSeats;

  const SelectedSeatsPage({Key? key, required this.selectedSeats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Seats'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selected Seats: ${selectedSeats.join(", ")}'),
            // You can add more widgets or actions based on the selected seats data
          ],
        ),
      ),
    );
  }
}

class SeatNumber {
  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  bool operator ==(Object other) {
    return rowI == (other as SeatNumber).rowI && colI == other.colI;
  }

  @override
  int get hashCode => rowI.hashCode;

  @override
  String toString() {
    return '[$rowI][$colI]';
  }
}