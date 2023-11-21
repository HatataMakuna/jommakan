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

      for (final row in results.rows) {
        userID = row.colByName("userID");
        userName = row.colByName("username");
        print(userID);
        print(userName);
      }

      // If not found or does not match with database, login failed
      if (userID == null || userName == null) {
        return {
          'success': false,
          'userID': userID,
          'username': userName,
        };
      }
      // If matches with the database, login succeed
      else {
        return {
          'success': true,
          'userID': userID,
          'username': userName,
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