import '../database/db_connection.dart';

class UserProfile {
  // Get user profile and display name and email in edit profile page
  Future<Map<String, dynamic>> getUserProfile(String username) async {
    try {
      final conn = await createConnection();

      // Retrieve user information based on the name
      var results = await conn.query('SELECT * FROM users WHERE username = ?', [username]);

      await conn.close();

      // If the user is found, return user data
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
    }
  }

  // Check if the provided current password matches the one stored in the database
  Future<bool> checkCurrentPassword(String username, String currentPassword) async {
    try {
      final conn = await createConnection();

      // Retrieve user information based on the username
      var results = await conn.query('SELECT * FROM users WHERE username = ?', [username]);

      await conn.close();

      // If the user is found, compare passwords
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
    }
  }

  // Update username and email in the database (username and email)
  Future<bool> updateNameEmail(String currentUsername, String username, String email) async {
    try {
      final conn = await createConnection();

      // Update user information based on the username
      await conn.query(
        'UPDATE users SET username = ?, email = ? WHERE username = ?',
        [username, email, currentUsername],
      );

      await conn.close();

      return true; // Update successful
    } catch (e) {
      print('Error updating user profile: $e');
      return false; // Update failed
    }
  }

  // Update password in the database
  Future<bool> updatePassword(String currentUsername, String password) async {
    try {
      final conn = await createConnection();

      // Update user information based on the username
      await conn.query('UPDATE users SET password = ? WHERE username = ?', [password, currentUsername]);

      await conn.close();

      return true; // Update successful
    } catch (e) {
      print('Error updating user profile: $e');
      return false; // Update failed
    }
  }

  // Update the whole user profile in the database (name, email and password)
  Future<bool> updateUserProfile(String currentUsername, String username, String email, String password) async {
    try {
      final conn = await createConnection();

      // Update user information based on the username
      await conn.query(
        'UPDATE users SET username = ?, email = ?, password = ? WHERE username = ?',
        [username, email, password, currentUsername],
      );

      await conn.close();

      return true; // Update successful
    } catch (e) {
      print('Error updating user profile: $e');
      return false; // Update failed
    }
  }
}