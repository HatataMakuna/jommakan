import 'package:jom_makan/database/db_connection.dart';

class UserProfile {
  // Get user profile and display name and email in edit profile page
  Future<Map<String, dynamic>> getUserProfile(String username) async {
    try {
      // Retrieve user information based on the name
      var results = await pool.execute('SELECT * FROM users WHERE username = :username', {"username": username});
      
      // If the user is found, return user data
      if (results.isNotEmpty) {
        String? email;

        for (final row in results.rows) {
          email = row.colByName("email");
        }
        
        return {
          'success': true,
          'username': username,
          'email': email,
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
      // Retrieve user information based on the username
      var results = await pool.execute('SELECT password FROM users WHERE username = :username', {"username": username});

      // If the user is found, compare passwords
      if (results.isNotEmpty) {
        String? password;
        for (final row in results.rows) {
          password = row.colByName("password");
        }
        return currentPassword == password;
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
      // Update user information based on the username
      await pool.execute(
        'UPDATE users SET username = :username, email = :email WHERE username = :curusername',
        {
          "username": username,
          "email": email,
          "curusername": currentUsername,
        },
      );

      return true; // Update successful
    } catch (e) {
      print('Error updating user profile: $e');
      return false; // Update failed
    }
  }

  // Update password in the database
  Future<bool> updatePassword(String currentUsername, String password) async {
    try {
      // Update user information based on the username
      await pool.execute(
        'UPDATE users SET password = :password WHERE username = :curusername',
        {
          "password": password,
          "curusername": currentUsername,
        },
      );

      return true; // Update successful
    } catch (e) {
      print('Error updating user profile: $e');
      return false; // Update failed
    }
  }

  // Update the whole user profile in the database (name, email and password)
  Future<bool> updateUserProfile(String currentUsername, String username, String email, String password) async {
    try {
      // Update user information based on the username
      await pool.execute(
        'UPDATE users SET username = :username, email = :email, password = :password WHERE username = :curusername',
        {
          "username": username,
          "email": email,
          "password": password,
          "curusername": currentUsername,
        },
      );

      return true; // Update successful
    } catch (e) {
      print('Error updating user profile: $e');
      return false; // Update failed
    }
  }
}