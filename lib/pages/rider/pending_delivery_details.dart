import 'package:flutter/material.dart';

class PendingDeliveryDetailsPage extends StatefulWidget {
  const PendingDeliveryDetailsPage({super.key});

  @override
  State<StatefulWidget> createState() => _PendingDeliveryDetailsPageState();
}

class _PendingDeliveryDetailsPageState extends State<PendingDeliveryDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Pending Delivery Details',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const Center(child: Text('Pending Delivery Details Page')),
    );
  }
}

/*
TODO: Pre-order display the time at the top of the screen
- Delivery fee, track my order
- Pre-order: display order status: preparation
*/