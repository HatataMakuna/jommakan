import 'package:jom_makan/database/db_connection.dart';

// TODO: To check whether the user has been registered as a rider. If not, redirect the user to the register page
class GetRiderInfo {
  Future<bool?> riderIsRegistered(int userID) async {
    try {
      var result = await pool.execute("SELECT * FROM riders WHERE userID = :userID", {"userID": userID});
      return result.isNotEmpty;
    } catch (e) {
      print('Error while checking rider info: $e');
      return null;
    }
  }
}