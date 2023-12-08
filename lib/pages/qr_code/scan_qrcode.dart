import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScanQRCode(),
    );
  }
}

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<StatefulWidget> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String? _qrResult;
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            color: Colors.blue,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color:Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32,
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              /* onError: (error) => ScaffoldMessanger.of(context).showSnackBar(
                SnackBar(content: Text('Error: $error'))
              ), */
              controller: cameraController,
              onDetect: (result) {
                final List<Barcode> barcodes = result.barcodes;
                final Uint8List? image = result.image;
                for (final barcode in barcodes) {
                  if (mounted) {
                    setState(() {
                      _qrResult = barcode.rawValue;
                    });
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          if (_qrResult != null) ...[
            Text(
              'QR Code Result: $_qrResult',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}