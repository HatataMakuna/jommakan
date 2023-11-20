
import 'package:jom_makan/database/db_connection.dart';

class promotion {
  Future<bool> promotionRegister({
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
      

      // Insert new user to the database
      var result = await pool.prepare(
        'INSERT INTO users (foodId, foodName, foodPrice, foodPromotion, foodStall, foodDescription) VALUES (?, ?, ?, ?, ?, ?)',
        
      );

      var results = await result.execute([foodId, foodName, foodPrice, foodPromotion, foodStall, foodDescription]);
      // Close the database connection
      await result.deallocate();


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