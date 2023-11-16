import '../database/db_connection.dart';

class LoginUser {
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final conn = await createConnection();

      // Check if the user exists with the given email and password
      var results = await conn.query(
        'SELECT * FROM users WHERE email = ? AND password = ?', [email, password]
      );

      await conn.close();

      // If the input matches with the database, login success
      if (results.isNotEmpty) {
        // Extract and return the username along with success status
        var user = results.first;
        var username = user['username']; // Change 'username' to the actual column name

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