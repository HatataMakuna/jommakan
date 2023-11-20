import 'package:jom_makan/database/db_connection.dart';

class LoginUser {
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // Check if the user exists with the given email and password
      var results = await pool.execute(
        'SELECT userID, username FROM users WHERE email = :email AND password = :password',
        {
          "email": email,
          "password": password,
        },
      );

      String? userID, userName;

      // If the input matches with the database, login success
      if (results.isNotEmpty) {
        for (final row in results.rows) {
          userID = row.colByName("userID");
          userName = row.colByName("username");
        }
        return {
          'success': true,
          'userID': userID,
          'username': userName,
        };
      } else {
        // If not, login failed; shows invalid username or password error
        return {
          'success': false,
          'userID': null,
          'username': null,
        };
      }
    } catch (e) {
      print('Error during login: $e');
      return {
        'success': false,
        'userID': null,
        'username': null,
      };
    }
  }
}