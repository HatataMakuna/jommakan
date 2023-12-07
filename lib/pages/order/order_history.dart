import 'package:flutter/material.dart';
import 'package:jom_makan/pages/order/order_details.dart';
import 'package:jom_makan/server/order/get_orders.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

// TODO: QR code scanner and display QR in history
// flutter: QR code bytes: [137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 1, 234, 0, 0, 1, 234, 1, 0, 0, 0, 0, 227, 22, 48, 151, 0, 0, 4, 82, 73, 68, 65, 84, 120, 156, 237, 157, 65, 110, 172, 72, 12, 134, 63, 15, 72, 89, 22, 210, 28, 32, 71, 129, 27, 228, 72, 79, 57, 210, 187, 1, 117, 148, 28, 160, 37, 88, 70, 2, 121, 22, 118, 21, 116, 102, 215, 240, 212, 211, 131, 189, 232, 208, 129, 79, 21, 164, 146, 93, 182, 255, 170, 136, 114, 192, 242, 95, 71, 104, 8, 60, 240, 192, 3, 15, 60, 240, 192, 3, 15, 252, 92, 92, 220, 90, 68, 58, 144, 129, 85, 96, 110, 237, 106, 119, 119, 152, 203, 151, 225, 188, 209, 3, 191, 26, 142, 170, 170, 210, 171, 170, 234, 212, 40, 253, 212, 40, 36, 85, 72, 11, 144, 84, 117, 76, 170, 254, 240, 212, 232, 142, 24, 95, 250, 221, 3, 127, 54, 62, 23, 247, 149, 59, 160, 255, 106, 209, 113, 246, 15, 249, 245, 213, 2, 73, 85, 6, 64, 68, 218, 147, 71, 15, 252, 90, 120, 241, 117, 19, 152, 155, 235, 39, 80, 213, 5, 213, 114, 5, 184, 19, 52, 119, 104, 95, 195, 215, 5, 126, 22, 174, 159, 29, 192, 252, 166, 50, 208, 152, 115, 211, 145, 85, 192, 62, 254, 232, 232, 129, 95, 11, 79, 170, 58, 2, 50, 148, 64, 10, 172, 66, 150, 55, 119, 110, 0, 50, 176, 249, 191, 19, 71, 15, 252, 146, 120, 22, 17, 145, 14, 91, 210, 21, 243, 128, 43, 191, 166, 242, 149, 146, 210, 158, 58, 122, 224, 23, 195, 109, 138, 109, 109, 49, 205, 239, 223, 162, 240, 45, 154, 223, 23, 52, 191, 23, 191, 150, 223, 23, 116, 255, 232, 9, 163, 7, 126, 101, 220, 170, 116, 34, 109, 241, 117, 115, 11, 204, 213, 165, 165, 5, 213, 105, 21, 25, 44, 234, 70, 189, 46, 240, 67, 102, 229, 55, 157, 192, 139, 118, 37, 165, 181, 43, 210, 130, 142, 128, 45, 253, 182, 146, 94, 228, 176, 129, 63, 110, 54, 207, 70, 234, 108, 154, 26, 221, 110, 208, 235, 82, 11, 41, 229, 198, 8, 196, 172, 11, 252, 128, 237, 38, 151, 181, 32, 172, 25, 81, 179, 212, 84, 170, 121, 94, 165, 91, 176, 187, 49, 235, 2, 127, 216, 118, 217, 132, 64, 187, 40, 172, 173, 103, 12, 233, 214, 194, 44, 64, 82, 132, 52, 65, 238, 38, 165, 159, 214, 146, 84, 188, 244, 187, 7, 254, 44, 124, 215, 155, 208, 177, 174, 220, 0, 182, 88, 75, 111, 143, 52, 119, 61, 140, 240, 117, 129, 31, 197, 147, 170, 37, 173, 185, 91, 133, 190, 212, 129, 117, 76, 11, 250, 41, 34, 214, 160, 5, 208, 207, 110, 141, 122, 93, 224, 7, 204, 35, 108, 150, 102, 241, 144, 10, 40, 52, 74, 126, 95, 16, 104, 161, 215, 181, 133, 116, 19, 139, 181, 253, 86, 179, 123, 233, 119, 15, 252, 89, 120, 173, 156, 52, 234, 237, 254, 210, 228, 183, 188, 214, 179, 137, 70, 119, 185, 70, 40, 157, 2, 63, 134, 223, 231, 176, 11, 251, 108, 118, 75, 90, 237, 209, 50, 245, 108, 113, 23, 179, 46, 240, 71, 237, 62, 135, 125, 83, 97, 238, 144, 126, 90, 91, 250, 223, 127, 219, 51, 210, 79, 29, 154, 7, 252, 134, 165, 180, 103, 140, 30, 248, 53, 113, 111, 245, 231, 1, 52, 127, 76, 214, 105, 21, 230, 14, 205, 93, 131, 230, 238, 134, 194, 210, 178, 41, 157, 114, 119, 43, 10, 129, 151, 126, 247, 192, 159, 133, 151, 198, 151, 89, 21, 175, 3, 187, 2, 177, 55, 40, 182, 26, 114, 172, 235, 2, 63, 142, 235, 72, 163, 214, 248, 50, 221, 122, 242, 43, 219, 60, 145, 165, 181, 15, 213, 47, 113, 9, 192, 137, 163, 7, 126, 53, 124, 159, 195, 142, 108, 109, 89, 160, 106, 57, 77, 198, 89, 21, 236, 46, 1, 8, 95, 23, 248, 195, 182, 211, 156, 152, 160, 169, 164, 180, 190, 71, 12, 74, 190, 90, 119, 75, 108, 22, 179, 46, 240, 35, 120, 90, 48, 85, 93, 182, 198, 67, 163, 251, 8, 219, 149, 125, 19, 185, 91, 173, 75, 33, 195, 153, 163, 7, 126, 45, 220, 146, 81, 33, 221, 208, 252, 113, 107, 197, 21, 236, 107, 105, 90, 124, 88, 93, 69, 5, 154, 197, 182, 241, 244, 95, 117, 219, 206, 75, 191, 123, 224, 207, 194, 119, 235, 58, 106, 89, 216, 110, 140, 119, 235, 186, 45, 194, 122, 114, 27, 17, 54, 240, 195, 248, 42, 37, 154, 110, 221, 175, 111, 251, 157, 12, 179, 249, 63, 241, 12, 247, 252, 209, 3, 191, 34, 158, 187, 70, 125, 183, 68, 221, 251, 106, 234, 39, 171, 225, 149, 228, 34, 191, 47, 208, 79, 171, 248, 212, 251, 79, 252, 241, 129, 191, 26, 94, 245, 117, 94, 175, 219, 106, 195, 165, 64, 82, 19, 89, 251, 221, 30, 139, 8, 27, 248, 99, 118, 183, 174, 171, 155, 34, 38, 40, 250, 18, 119, 115, 59, 205, 103, 31, 154, 147, 192, 15, 89, 221, 114, 189, 138, 235, 235, 210, 173, 85, 230, 102, 177, 60, 53, 127, 76, 42, 253, 239, 22, 33, 249, 147, 123, 145, 251, 75, 191, 123, 224, 207, 194, 107, 31, 182, 234, 235, 74, 209, 216, 90, 21, 222, 42, 171, 94, 15, 176, 21, 94, 248, 186, 192, 31, 183, 251, 102, 195, 191, 4, 117, 174, 244, 132, 77, 85, 23, 149, 147, 192, 207, 242, 117, 0, 85, 2, 160, 85, 218, 121, 191, 131, 98, 219, 168, 19, 179, 46, 240, 195, 120, 95, 226, 170, 215, 230, 230, 55, 149, 97, 246, 61, 58, 62, 49, 127, 54, 200, 206, 27, 61, 240, 139, 226, 245, 172, 78, 104, 212, 78, 119, 114, 205, 73, 163, 50, 108, 53, 100, 145, 90, 200, 59, 113, 244, 192, 175, 133, 255, 60, 171, 115, 203, 28, 202, 153, 38, 247, 143, 39, 247, 137, 17, 97, 3, 63, 19, 159, 235, 153, 78, 236, 203, 119, 37, 135, 93, 197, 27, 25, 127, 102, 244, 192, 175, 132, 39, 45, 103, 117, 226, 7, 118, 22, 85, 83, 9, 179, 210, 53, 234, 231, 140, 165, 239, 88, 215, 5, 126, 196, 126, 228, 176, 246, 115, 183, 1, 246, 254, 76, 29, 43, 213, 77, 209, 17, 11, 252, 136, 73, 252, 247, 186, 192, 3, 15, 60, 240, 192, 3, 15, 60, 240, 255, 5, 254, 15, 105, 107, 183, 235, 0, 34, 7, 66, 0, 0, 0, 0, 73, 69, 78, 68, 174, 66, 96, 130]

/*
get the qr code
qrCode - get from database

Widget _loadQrCode() {
    Uint8List qrCode = Provider.of<SeatListProvider>(context, listen: false).qrCodeBytes;
    return SizedBox(
      height: 200,
      width: 200,
      child: PhotoView(
        imageProvider: MemoryImage(qrCode),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2,
        backgroundDecoration: const BoxDecoration(color: Colors.white),
      ),
    );
*/


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
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        orderItem['date'],
                        style: const TextStyle(
                          fontSize: 15,
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
                        image: AssetImage('images/foods/${orderItem['food_image']}'),
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
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'RM ${double.parse(orderItem['price']).toStringAsFixed(2)} (${orderItem['quantity'].toString()} ITEMS) - ${orderItem['payment']}',
                            style: const TextStyle(
                              fontSize: 12,
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
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                  else ...[
                    Text(
                      orderItem['status'],
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 12,
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