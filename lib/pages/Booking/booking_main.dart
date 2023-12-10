import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:jom_makan/model/seat_number.dart';
import 'package:jom_makan/pages/Booking/qr_display.dart';
import 'package:jom_makan/server/seat_display/seat_display.dart';
import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jom_makan/stores/seatlist_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SeatListProvider(),
      child: const BookSeatPage(),
    )
  );
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
      home: BusLayout(selectedSeatsNotifier: ValueNotifier<String>(''),),
    );
  }
}

class BusLayout extends StatefulWidget {
  final ValueNotifier<String> selectedSeatsNotifier;
  const BusLayout({super.key, required this.selectedSeatsNotifier});

  @override
  State<StatefulWidget> createState() => _BusLayoutState();
}

class _BusLayoutState extends State<BusLayout> {
  Set<SeatNumber> selectedSeats = {};
  Uint8List? qrCodeBytes; // Use Uint8List to store image bytes
  final SeatDisplay addSeat = SeatDisplay();
  
  //final TextEditingController _rowController = TextEditingController();
  var itemData = [];

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
      Uri.parse('http://10.0.2.2:5000/generate_qr'),
      // Windows: http://127.0.0.1:5000/...
      // Android: http://10.0.2.2:5000/...
      // Uri.parse('http://your-flask-server-ip:5000/generate_qr'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'data': seatsList,
      }),
    );
    print(seatsList.map((seat) => seat['rowI']).toList());

    if (response.statusCode == 200) {
      final File file = File('assets/example.png');
      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        qrCodeBytes = response.bodyBytes;
      });

      // Navigate to a new page to display the QR code
      goToQrDisplayPage(selectedSeats);
    } else {
      // Handle errors
      print('Failed to generate QR code: ${response.statusCode}');
    }
  }

  void goToQrDisplayPage(Set<SeatNumber> selectedSeats) {
    //print('QR code bytes: $qrCodeBytes');
    // Store the QR code bytes to provider
    //Provider.of<SeatListProvider>(context, listen: false).setQrCodeBytes(qrCodeBytes!);

    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => QRCodeDisplayPage(
          //qrCodeBytes: qrCodeBytes!,
          selectedSeats: selectedSeats,
          selectedSeatsNotifier: widget.selectedSeatsNotifier,
        ),
      ),
    ).then((selectedSeats) {
      Navigator.pop(context, selectedSeats);
    });
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
              const SizedBox(height: 12),
              const SizedBox(height: 12),
              Text(selectedSeats.join(" , ")), // Display selected seat numbers directly
              const SizedBox(height: 12),
              // Add a button to generate the QR code
              ElevatedButton(
                onPressed: () {
                  if (selectedSeats.isEmpty) {
                    const snackBar = SnackBar(content: Text('Please select your seat(s)'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    showSeatConfirmation();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) => const Color(0xFFfc4c4e)),
                ),
                child: const Text('Generate QR Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSeatConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation?'),
          content: Text('Are you sure you want to book the following seat(s): $selectedSeats'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop();
                goToQrDisplayPage(selectedSeats);
                seatAdded();
              },
            ),
          ],
        );
      }
    );
  }

  // Passing the data to "server/register.dart" for performing the server-side script
  void seatAdded() {
    // Generate a unique confirmationID (starting from C0001)
    String confirmationID =
      'C${DateTime.now().millisecondsSinceEpoch % 10000}'.padLeft(5, '0');

    // Assume that location is always "RedBrick Cafe"
    String location = 'RedBrick Cafe';

    // Get the current date and time
    DateTime now = DateTime.now();

    List<Map<String, dynamic>> seatsList = [];

    for (SeatNumber seat in selectedSeats) {
      int row = seat.rowI;
      int col = seat.colI;

      Map<String, dynamic> seatData = {
        'confirmationID': confirmationID,
        'row': row,
        'col': col,
        'location': location,
        'time': now,
      };

      seatsList.add(seatData);
    }

    // Store the selected seat details to the provider
    Provider.of<SeatListProvider>(context, listen: false).setSeatList(seatsList);
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
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedSeatsNotifier extends ValueNotifier<List<String>> {
  SelectedSeatsNotifier() : super([]);

  void updateSeats(List<String> newSeats) {
    value = newSeats;
  }
}