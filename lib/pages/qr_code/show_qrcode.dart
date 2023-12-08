import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scan QR Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShowQRCode(username: 'Testing'),
    );
 }
}

class ShowQRCode extends StatefulWidget {
  final String username;
  const ShowQRCode({super.key, required this.username});

  @override
  State<StatefulWidget> createState() => _ShowQRCodeState();
}

class _ShowQRCodeState extends State<ShowQRCode> {
  //String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _loadContent(),
          ),
        ],
      ),
    );
  }

  Widget _loadContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrImageView(
            data: widget.username,
            version: QrVersions.auto,
            size: 200.0,
          ),
          const SizedBox(height: 20),
          Text('Username: ${widget.username}'),
        ],
      ),
    );
  }
}