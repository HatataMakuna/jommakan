import 'package:jom_makan/database/db_connection.dart';

class Register {
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Check if the user already exists
      final existingUser = await getUserByEmail(email);
      if (existingUser) {
        // User with this email already exists, registration failed
        return false;
      }

      // User doesn't exist, proceed with registration
      // Insert new user into the database
      var result = await pool.execute(
        'INSERT INTO users (username, email, password) VALUES (:name, :email, :password)',
        {
          "name": name,
          "email": email,
          "password": password,
        },
      );

      return result.affectedRows as int == 1; // Check if the insertion was successful
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error during registration: $e');
      return false;
    }
  }

  Future<bool> getUserByEmail(String email) async {
    try {
      var results = await pool.execute('SELECT * FROM users WHERE email = :email', {"email": email});

      if (results.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error fetching user by email: $e');
      return true;
    }
  }
}
