import 'package:jom_makan/database/db_connection.dart';

class RegisterAsRider {
  Future<bool> registerRider(int userID) async {
    try {
      var result = await pool.execute("INSERT INTO riders (userID) VALUES :userID", {"userID": userID});
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print("Error while registering as rider: $e");
      return false;
    }
  }
}