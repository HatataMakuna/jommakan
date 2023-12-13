import 'package:jom_makan/database/db_connection.dart';

class Register {
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Insert new user into the database
      var result = await pool.execute(
        'INSERT INTO users (username, email, password) VALUES (:name, :email, :password)',
        {
          "name": name,
          "email": email,
          "password": password,
        },
      );

      return result.affectedRows.toInt() == 1; // Check if the insertion was successful
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error during registration: $e');
      return false;
    }
  }

  Future<bool> getUserByEmail(String email) async {
    try {
      var results = await pool.execute('SELECT email FROM users WHERE email = :email', {"email": email});

      String? existingEmail;

      for (final row in results.rows) {
        existingEmail = row.colAt(0);
      }
      print('Email checking: ' + existingEmail.toString());

      if (existingEmail == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print('Error fetching user by email: $e');
      return true;
    }
  }
}
