/*
  - List all the orders with "delivery" pending status (in progress) [get the list of pending orders with delivery method from the database]
  - Let riders to choose which they want to deliver [show confirmation]
  - Do not allow rider to choose when they had one delivery in progress
  - When the order has arrived to customer, they can tap on "Done" button to complete the delivery; the order status will change to completed

  Database schema:
  delivery (deliveryID, orderID, address, status)
  orders (orderID, userID, noCutlery, status, paymentID, total_price, order_method)
  order_details (odetailsID, orderID, foodID, quantity, price, no_vege, extra_vege, no_spicy, extra_spicy, notes)

  How to display?
  Order ID - Username - Total no. of foods ordered - Ordered on

  When click on the row - show the order details - provide an option to accept the delivery
  [show confirmation message]
*/

import 'package:flutter/material.dart';
import 'package:jom_makan/pages/rider/delivery_details.dart';
import 'package:jom_makan/server/rider/get_pending_delivery.dart';

class PendingDeliveryPage extends StatefulWidget {
  const PendingDeliveryPage({super.key});

  @override
  State<StatefulWidget> createState() => _PendingDeliveryPageState();
}

class _PendingDeliveryPageState extends State<PendingDeliveryPage> {
  final GetPendingDelivery _getPendingDelivery = GetPendingDelivery();
  List<Map<String, dynamic>> _deliveryList = [];

  @override
  void initState() {
    super.initState();
    _getDeliveries();
  }

  void _getDeliveries() async {
    try {
      final deliveryList = await _getPendingDelivery.getPendingDeliveries();

      if (mounted) {
        setState(() {
          _deliveryList = deliveryList;
        });
      }
    } catch (e) {
      print('Error fetching pending delivery list: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Pending Deliveries',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loadPendingDeliveryList(),
      ),
    );
  }

  Widget _loadPendingDeliveryList() {
    return ListView(
      children: [
        // Header
        Container(
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeaderCell('Order ID', width: 80),
              _buildHeaderCell('Username', width: 120),
              _buildHeaderCell('Total no. of food ordered', width: 120),
              _buildHeaderCell('Ordered on', width: 120),
            ],
          ),
        ),
        // Data rows
        for (int index = 0; index < _deliveryList.length; index++)
          _buildDeliveryItem(_deliveryList[index]),
      ],
    );
  }

  Widget _buildHeaderCell(String text, {double width = 100}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDeliveryItem(Map<String, dynamic> delivery) {
    return Card(
      color: _deliveryList.indexOf(delivery) % 2 == 0 ? Colors.white : const Color(0xFFD3D3D3),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeliveryDetails(selectedDelivery: delivery),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDataCell('${delivery['orderID']}', width: 80),
            _buildDataCell('${delivery['username']}', width: 120),
            _buildDataCell('${delivery['foodCount']}', width: 120),
            _buildDataCell('${delivery['orderedOn']}', width: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, {double width = 100}) {
    return Expanded(
      child: Container(
        width: width,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}