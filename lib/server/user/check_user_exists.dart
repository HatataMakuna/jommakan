import 'package:jom_makan/database/db_connection.dart';

class CheckUserExists {
  Future<bool> checkUser({required String email}) async {
    try {
      var result = await pool.execute("SELECT username FROM users WHERE email = :email", {"email": email});

      List<Map<String, dynamic>> results = [];
      for (final row in result.rows) {
        results.add({
          "username": row.colAt(0),
        });
      }

      if (results.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error while checking user existence: $e");
      return false;
    }
  }
}