import 'package:jom_makan/database/db_connection.dart';

class AssignDelivery {
  Future<int> getRiderID({required int userID}) async {
    try {
      var result = await pool.execute(
        "SELECT riderID FROM riders WHERE userID = :userID", {"userID": userID}
      );

      int riderID = 0;
      for (final row in result.rows) {
        riderID = int.parse(row.colAt(0)!);
      }

      return riderID;
    } catch (e) {
      print('Error while getting rider ID: $e');
      return 0;
    }
  }
  
  Future<bool> assignDelivery({required int orderID, required int riderInCharge}) async {
    try {
      var result = await pool.execute('''
        UPDATE delivery SET status = 'In progress', rider_in_charge = :rider_in_charge WHERE orderID = :orderID
      ''', {
        "rider_in_charge": riderInCharge,
        "orderID": orderID,
      });

      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print('Error while assigning delivery: $e');
      return false;
    }
  }
}