import 'package:jom_makan/database/db_connection.dart';
import 'package:mysql1/mysql1.dart';

class LoginUser {
  final MySqlConnectionPool _connectionPool;

  LoginUser(this._connectionPool);

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    MySqlConnection? conn;

    try {
      conn = await _connectionPool.getConnection();

      // Check if the user exists with the given email and password
      var results = await conn.query(
        'SELECT * FROM users WHERE email = ? AND password = ?', [email, password]
      );

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
    } finally {
      // Release the connection back to the pool
      await conn?.close();
    }
  }
}