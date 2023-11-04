import '../database/db_connection.dart';

class Register {
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Check if the user already exists
      final existingUser = await getUserByEmail(email);
      if (existingUser != null) {
        // User with this email already exists, registration failed
        return false;
      }

      // User doesn't exist, proceed with registration
      final conn = await createConnection();

      // Insert new user to the database
      var result = await conn.query(
        'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
        [name, email, password],
      );

      // Close the database connection
      await conn.close();

      // Check if the insertion was successful
      if (result.affectedRows == 1) {
        // User registered successfully
        return true;
      } else {
        // Insertion failed
        return false;
      }
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error during registration: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final conn = await createConnection();

    var results = await conn.query('SELECT * FROM users WHERE email = ?', [email]);

    await conn.close();

    if (results.isNotEmpty) {
      // User found, return user data as a Map
      return results.first.fields;
    } else {
      // Uesr not found
      return null;
    }
  }
}