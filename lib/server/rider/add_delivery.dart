import 'package:intl/intl.dart';
import 'package:jom_makan/database/db_connection.dart';

class AddDelivery {
  Future<void> addDelivery({required int orderID, required String address}) async {
    String orderedDate = DateFormat('dd-MMM-yyyy HH:mm:ss').format(DateTime.now());

    try {
      await pool.execute("INSERT INTO delivery (orderID, address, orderedOn) VALUES (:orderID, :address, :orderedOn)", {
        "orderID": orderID, "address": address, "orderedOn": orderedDate,
      });
    } catch (e) {
      print('Error while adding delivery order: $e');
    }
  }
}