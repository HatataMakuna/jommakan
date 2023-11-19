import 'package:jom_makan/database/db_connection.dart';

class LoginUser {
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // Check if the user exists with the given email and password
      var results = await pool.execute(
        'SELECT username FROM users WHERE email = :email AND password = :password',
        {
          "email": email,
          "password": password,
        },
      );

      // If the input matches with the database, login success
      if (results.isNotEmpty) {
        var username = results.first;
        return {'success': true, 'username': username};
      } else {
        // If not, login failed; shows invalid username or password error
        return {'success': false, 'username': null};
      }
    } catch (e) {
      print('Error during login: $e');
      return {'success': false, 'username': null};
    }
  }
}