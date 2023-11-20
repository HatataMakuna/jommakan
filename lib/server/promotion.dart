import '../database/db_connection.dart';

class promotion {
  Future<bool> promomtionRegister({
    required String foodId,
    required String foodName,
required String foodPrice,
required String foodPromotion,
required String foodStall,
required String foodDescription,
  }) async {
    // try {
    //   // Check if the user already exists
    //   final existingUser = await getUserByEmail(email);
    //   if (existingUser != null) {
    //     // User with this email already exists, registration failed
    //     return false;
    //   }

      // User doesn't exist, proceed with registration
      final conn = await createConnection();

      // Insert new user to the database
      var result = await conn.query(
        'INSERT INTO users (foodId, foodName, foodPrice, foodPromotion, foodStall, foodDescription) VALUES (?, ?, ?, ?, ?, ?)',
        [foodId, foodName, foodPrice, foodPromotion, foodStall, foodDescription],
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
    // } catch (e) {
    //   // Handle database errors or other exceptions here
    //   print('Error during generate the Promotion: $e');
    //   return false;
    // }


    
  }

  Future<Map<String, dynamic>?> getPromotion() async {
    final conn = await createConnection();

    var results = await conn.query('SELECT * FROM promotion');

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