import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


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


 Future<void> reserveSeats() async {
  try {
    // Convert selectedSeats to a list of Map<String, dynamic>
    List<Map<String, dynamic>> selectedSeatsList = selectedSeats
        .map((seat) => {'rowI': seat.rowI, 'colI': seat.colI})
        .toList();

    // Replace this with the actual data you want to send
    Map<String, dynamic> requestData = {'data': json.encode(selectedSeatsList)};

    // Send selected seat data to Flask API
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/generate_qr_code'),
      body: requestData,
    );

    if (response.statusCode == 200) {
      // Parse the response and handle the generated QR code data
      Map<String, dynamic> responseData = json.decode(response.body);
      String qrCodeData = responseData['qr_code_data'];

      // Print the received QR code data (for testing purposes)
      print('Received QR Code Data: $qrCodeData');
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}



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
            const Text("Please Selected the Seat"),
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
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) => const Color(0xFFfc4c4e)),
              ),
              child: const Text('Show my selected seat numbers'),
            ),
            const SizedBox(height: 12),
            Text(selectedSeats.join(" , ")),
           
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
