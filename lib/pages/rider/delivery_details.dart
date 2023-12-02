import 'package:flutter/material.dart';
import 'package:jom_makan/pages/rider/order_item.dart';
import 'package:jom_makan/server/order/get_orders.dart';
import 'package:jom_makan/server/rider/assign_delivery.dart';
import 'package:jom_makan/server/rider/complete_delivery.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  // Ordered on: [date]
  // List all the orders and its details
  // button to assign delivery
  final Map<String, dynamic> selectedDelivery;
  const DeliveryDetails({super.key, required this.selectedDelivery});

  @override
  State<StatefulWidget> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  final GetOrders _getOrders = GetOrders();
  final AssignDelivery _assignDelivery = AssignDelivery();
  final CompleteDelivery _completeDelivery = CompleteDelivery();
  List<Map<String, dynamic>> _orderDetails = [];

  @override
  void initState() {
    super.initState();
    _getOrderDetails();
  }

  void _getOrderDetails() async {
    try {
      int orderID = int.parse(widget.selectedDelivery['orderID']);
      List<Map<String, dynamic>> orderDetails = await _getOrders.getOrderDetailsByOrderID(orderID);

      if (mounted) {
        setState(() {
          _orderDetails = orderDetails;
        });
      }
    } catch (e) {
      print('Error fetching order details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Delivery Details',
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
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text('Order Items', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            loadOrderList(),
            const SizedBox(height: 16),
            _getDeliveryStatus(),
            Text(
              'Ordered By: ${widget.selectedDelivery['username']}',
              style: const TextStyle(fontSize: 12)
            ),
            Text(
              'Ordered On: ${widget.selectedDelivery['orderedOn']}',
              style: const TextStyle(fontSize: 12, color: Colors.grey)
            ),
            if (widget.selectedDelivery['status'] == 'Pending') ...[
              const SizedBox(height: 16),
              assignDeliveryButton(),
            ]
            else if (widget.selectedDelivery['status'] == 'In progress') ...[
              const SizedBox(height: 16),
              completeDeliveryButton(),
            ]
            else ...[
              const SizedBox.shrink(),
            ],
          ],
        ),
      ),
    );
  }

  Widget loadOrderList() {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 400,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _orderDetails.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> item = _orderDetails[index];
          return OrderItemWidget(item: item, selectedDelivery: widget.selectedDelivery,);
        },
      ),
    );
  }

  Widget _getDeliveryStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Delivery Status: ', style: TextStyle(fontSize: 12)),
        Text('${widget.selectedDelivery['status']}', style: TextStyle(
          color: widget.selectedDelivery['status'] == 'Pending' ? Colors.yellow : Colors.green,
          fontSize: 12,
        )),
      ],
    );
  }
  
  Widget assignDeliveryButton() {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmation'),
              content: const Text('Are you sure you want to assign yourself to this delivery?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    assignDelivery();
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      child: const Text('Assign Delivery'),
    );
  }

  void assignDelivery() async {
    int riderInCharge = await _assignDelivery.getRiderID(
      userID: Provider.of<UserProvider>(context, listen: false).userID!
    );
    bool status = await _assignDelivery.assignDelivery(
      orderID: int.parse(widget.selectedDelivery['orderID']), riderInCharge: riderInCharge
    );

    showAssignDeliveryStatus(status);
  }

  void showAssignDeliveryStatus(bool status) {
    if (status) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('You have been assigned to this order'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        }
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sorry!'),
            content: const Text('An error occurred while assigning delivery. Please try again later.'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        }
      );
    }
  }

  Widget completeDeliveryButton() {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmation'),
              content: const Text('Are you sure you want to complete this delivery?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    completeDelivery();
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      child: const Text('Complete Delivery'),
    );
  }

  void completeDelivery() async {
    bool status = await _completeDelivery.completeOrder(
      orderID: int.parse(widget.selectedDelivery['orderID'])
    );
    status = await _completeDelivery.completeDelivery(
      orderID: int.parse(widget.selectedDelivery['orderID'])
    );

    showCompleteDeliveryStatus(status);
  }

  void showCompleteDeliveryStatus(bool status) {
    if (status) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Your delivery has been completed'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        }
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sorry!'),
            content: const Text('An error occurred while completing delivery. Please try again later.'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        }
      );
    }
  }
}