import 'package:jom_makan/database/db_connection.dart';

class GetRiderInfo {
  Future<bool?> riderIsRegistered(int userID) async {
    try {
      var result = await pool.execute("SELECT * FROM riders WHERE userID = :userID", {"userID": userID});
      
      if (result.isNotEmpty) {
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