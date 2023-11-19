import 'package:jom_makan/database/db_connection.dart';
import 'package:mysql1/mysql1.dart';

class Register {
  final MySqlConnectionPool _connectionPool;

  Register(this._connectionPool);

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    MySqlConnection? conn;

    try {
      // Check if the user already exists
      final existingUser = await getUserByEmail(email);
      if (existingUser != null) {
        // User with this email already exists, registration failed
        return false;
      }

      // User doesn't exist, proceed with registration
      conn = await _connectionPool.getConnection();

      // Insert new user into the database
      var result = await conn.query(
        'INSERT INTO users (username, email, password) VALUES (?, ?, ?)',
        [name, email, password],
      );

      return result.affectedRows == 1; // Check if the insertion was successful
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error during registration: $e');
      return false;
    } finally {
      // Release the connection back to the pool
      await conn?.close();
    }
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    MySqlConnection? conn;

    try {
      conn = await _connectionPool.getConnection();

      var results = await conn.query('SELECT * FROM users WHERE email = ?', [email]);

      return results.isNotEmpty ? results.first.fields : null;
    } catch (e) {
      print('Error fetching user by email: $e');
      return null;
    } finally {
      await conn?.close();
    }
  }
}
