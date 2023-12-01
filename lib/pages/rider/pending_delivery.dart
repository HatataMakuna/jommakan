/*
  TODO: (tasks)
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
        child: _loadTwo(),
      ),
    );
  }

  Widget _loadTwo() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(
        color: Colors.grey,
        width: 1,
      ),
      children: [
        // Header row
        const TableRow(
          decoration: BoxDecoration(
            color: Color(0xFFE0E0E0),
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Order ID',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Username',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Total no. of food ordered',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Ordered on',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        // Data rows
        for (int index = 0; index < _deliveryList.length; index++) ...[
          TableRow(
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.white : Colors.grey,
            ),
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${_deliveryList[index]['orderID']}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${_deliveryList[index]['username']}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${_deliveryList[index]['foodCount']}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${_deliveryList[index]['orderedOn']}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _loadPendingDeliveryList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: _deliveryList.length,
      itemBuilder: (context, index) {
        final pendingItem = _deliveryList[index];
        final isEven = index % 2 == 0;
        final backgroundColor = isEven ? Colors.white : Colors.grey[200];

        return Card(
          elevation: 5,
          color: backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: ListTile(
            title: Text(
              'Order ID: ${pendingItem['orderID']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            subtitle: Text(
              '''
                Username: ${pendingItem['username']}
                Total no. of foods ordered: ${pendingItem['foodCount']}
                Ordered on: ${pendingItem['orderedOn']}
              ''',
              style: const TextStyle(fontSize: 12),
            ),
            onTap: () {
              // Navigate to the delivery details
            }
          ),
        );
      },
    );
  }
}