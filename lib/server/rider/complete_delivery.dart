import 'package:jom_makan/database/db_connection.dart';

class CompleteDelivery {
  Future<bool> completeOrder({required int orderID}) async {
    try {
      var result = await pool.execute(
        "UPDATE orders SET status = 'Completed' WHERE orderID = :orderID",
        {"orderID": orderID}
      );

      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print('Error while completing order: $e');
      return false;
    }
  }

  Future<bool> completeDelivery({required int orderID}) async {
    try {
      var result = await pool.execute(
        "UPDATE delivery SET status = 'Completed' WHERE orderID = :orderID",
        {"orderID": orderID}
      );

      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print('Error while completing delivery: $e');
      return false;
    }
  }
}