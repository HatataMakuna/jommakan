import 'package:jom_makan/database/db_connection.dart';

class ResetPasswordLogic {
  Future<bool> resetPassword({required String newPassword, required String email}) async {
    try {
      var result = await pool.execute("UPDATE users SET password = :password WHERE email = :email", {
        "password": newPassword,
        "email": email,
      });

      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print("Error while resetting password: $e");
      return false;
    }
  }
}