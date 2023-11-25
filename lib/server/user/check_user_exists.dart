import 'package:jom_makan/database/db_connection.dart';

class CheckUserExists {
  Future<bool> checkUser({required String email}) async {
    try {
      var result = await pool.execute("SELECT * FROM users WHERE email = :email", {"email": email});

      if (result.isNotEmpty) {
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