import 'package:flutter/material.dart';
import 'package:jom_makan/pages/rider/delivery_details.dart';
import 'package:jom_makan/server/rider/get_pending_delivery.dart';

class MyDeliveries extends StatefulWidget {
  final int userID;
  const MyDeliveries({super.key, required this.userID});

  @override
  State<StatefulWidget> createState() => _MyDeliveriesState();
}

class _MyDeliveriesState extends State<MyDeliveries> {
  final GetPendingDelivery _getPendingDelivery = GetPendingDelivery();
  bool loading = true;
  List<Map<String, dynamic>> _deliveries = [];

  @override
  void initState() {
    super.initState();
    _getMyDeliveries();
  }

  void _getMyDeliveries() async {
    try {
      List<Map<String, dynamic>> deliveries = await _getPendingDelivery.getMyDeliveries(userID: widget.userID);

      if (mounted) {
        setState(() {
          _deliveries = deliveries;
          loading = false;
        });
      }
    } catch (e) {
      print('Error fetching my deliveries: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'My Deliveries',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: loading ? const Center(child: CircularProgressIndicator())
        : Padding(
          padding: const EdgeInsets.all(16.0),
          child: _loadMyDeliveries(),
        )
    );
  }

  Widget _loadMyDeliveries() {
    return ListView.builder(
      itemCount: _deliveries.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context, MaterialPageRoute(
                builder: (context) => DeliveryDetails(selectedDelivery: _deliveries[index]),
              ),
            );
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Text(
                _deliveries[index]['orderID'].toString(),
                style: const TextStyle(fontSize: 14)
              ),
            ),
            title: Text(_deliveries[index]['username'].toString()),
            subtitle: Text('Food Count: ${_deliveries[index]['foodCount'].toString()}'),
            trailing: Text(
              _deliveries[index]['status'].toString(),
              style: const TextStyle(color: Colors.green, fontSize: 14)
            ),
          ),
        );
      },
    );
  }
}