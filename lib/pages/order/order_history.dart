import 'package:flutter/material.dart';
import 'package:jom_makan/pages/order/order_details.dart';
import 'package:jom_makan/server/order/get_orders.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final GetOrders _getOrders = GetOrders();
  List<Map<String, dynamic>> _orderHistory = [];

  @override
  void initState() {
    super.initState();
    _loadOrderHistory();
  }

  Future<void> _loadOrderHistory() async {
    try {
      final orderHistory = await _getOrders.getAllOrders(
        Provider.of<UserProvider>(context, listen: false).userID!
      );

      if (mounted) {
        setState(() {
          _orderHistory = orderHistory;
        }); 
      }
    } catch (e) {
      print('Error loading order history: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Order History',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _initialiseOrderHistoryPage(),
    );
  }

  Widget _initialiseOrderHistoryPage() {
    if (_orderHistory.isEmpty) {
      return const Center(child: Text('No order history.'));
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildOrderHistoryContent(),
      );
    }
  }

  Widget _buildOrderHistoryContent() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: _orderHistory.length,
      itemBuilder: (context, index) {
        final orderItem = _orderHistory[index];

        return Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailsPage(selectedOrderItem: orderItem),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        orderItem['odetailsID'].toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        orderItem['date'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage('images/foods/' + orderItem['food_image']),
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderItem['food_name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'RM ${orderItem['price'] ?? ''} (${orderItem['quantity'].toString()} ITEMS) - ${orderItem['payment']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (orderItem['status'] == 'Completed') ...[
                    Text(
                      orderItem['status'],
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                  else ...[
                    Text(
                      orderItem['status'],
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}