import 'package:jom_makan/database/db_connection.dart';
import 'package:mysql1/mysql1.dart';

class UserProfile {
  final MySqlConnectionPool _connectionPool;

  UserProfile(this._connectionPool);

  Future<Map<String, dynamic>> getUserProfile(String username) async {
    //await _connectionPool.initConnections(); // Ensure the connection pool is initialized
    MySqlConnection? conn;

    try {
      conn = await _connectionPool.getConnection();
      String query = 'SELECT * FROM users WHERE UPPER(username) LIKE UPPER(?)';
      String usernameValue = '%$username%';

      final results = await conn.query(query, [usernameValue]);

      print('SELECT * FROM users WHERE UPPER(username) LIKE UPPER(?)');
      print('Parameters: [$usernameValue]');
      print('Results: $results');
      
      if (results.isNotEmpty) {
        var user = results.first;
        
        var username = user['username'];
        var userEmail = user['email'];

        return {
          'success': true,
          'username': username,
          'email': userEmail,
        };
      } else {
        // User not found
        return {'success': false, 'username': null, 'email': null};
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return {'success': false, 'username': null, 'email': null};
    } finally {
      await conn?.close();
    }
  }

  Future<bool> checkCurrentPassword(String username, String currentPassword) async {
    MySqlConnection? conn;

    try {
      conn = await _connectionPool.getConnection();

      var results = await conn.query('SELECT * FROM users WHERE username = ?', [username]);

      if (results.isNotEmpty) {
        var user = results.first;
        var storedPassword = user['password']; // Replace 'password' with the actual column name

        return currentPassword == storedPassword;
      } else {
        // User not found
        return false;
      }
    } catch (e) {
      print('Error checking current password: $e');
      return false;
    } finally {
      await conn?.close();
    }
  }

  Future<bool> updateNameEmail(String currentUsername, String username, String email) async {
    MySqlConnection? conn;

    try {
      conn = await _connectionPool.getConnection();

      await conn.query(
        'UPDATE users SET username = ?, email = ? WHERE username = ?',
        [username, email, currentUsername],
      );

      return true; // Update successful
    } catch (e) {
      print('Error updating user profile: $e');
      return false; // Update failed
    } finally {
      await conn?.close();
    }
  }

  Future<bool> updatePassword(String currentUsername, String password) async {
    MySqlConnection? conn;

    try {
      conn = await _connectionPool.getConnection();

      await conn.query('UPDATE users SET password = ? WHERE username = ?', [password, currentUsername]);

      return true; // Update successful
    } catch (e) {
      print('Error updating user profile: $e');
      return false; // Update failed
    } finally {
      await conn?.close();
    }
  }

  Future<bool> updateUserProfile(String currentUsername, String username, String email, String password) async {
    MySqlConnection? conn;

    try {
      conn = await _connectionPool.getConnection();

      await conn.query(
        'UPDATE users SET username = ?, email = ?, password = ? WHERE username = ?',
        [username, email, password, currentUsername],
      );

      return true; // Update successful
    } catch (e) {
      print('Error updating user profile: $e');
      return false; // Update failed
    } finally {
      await conn?.close();
    }
  }
}
