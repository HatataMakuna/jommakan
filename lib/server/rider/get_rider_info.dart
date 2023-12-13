import 'package:jom_makan/database/db_connection.dart';

class GetRiderInfo {
  Future<bool?> riderIsRegistered(int userID) async {
    try {
      var result = await pool.execute("SELECT * FROM riders WHERE userID = :userID", {"userID": userID});

      List<Map<String, dynamic>> results = [];
      for (final row in result.rows) {
        results.add({
          "riderID": row.colAt(0),
          "userID": row.colAt(1),
        });
      }
      
      if (results.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error while checking rider info: $e');
      return null;
    }
  }
}