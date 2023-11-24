import 'dart:convert';
import 'dart:io';

import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:jom_makan/pages/Booking/styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'dart:typed_data';
import 'package:http/http.dart' as http;

import '../main/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

String qrCodeData = ''; // Add this variable to store the QR code image URL

Future<void> generateQRCode(Set<SeatNumber> selectedSeats) async {
  final List<Map<String, int>> seatsList = selectedSeats
      .map((seat) => {'rowI': seat.rowI, 'colI': seat.colI})
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

    // Debug print the response body
    print('Server response body: ${response.body}');
    // Assume the Flask server returns the QR code image URL in the response

    final File file = File('assets/example.png');
    
    
      setState(() {
        qrCodeData = jsonDecode(response.body)['qrCodeData'].toString();
      });
  } else {
    // Handle errors
    print('Failed to generate QR code: ${response.statusCode}');
  }
}

  // function to display qr code



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            const Text("Please Select Your Seat"),
            const SizedBox(
              height: 32,
            ),
            Flexible(
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
            if (qrCodeData.isNotEmpty)
              QrImageView(
                data: qrCodeData,
                version: QrVersions.auto,
                size: 200.0,
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
