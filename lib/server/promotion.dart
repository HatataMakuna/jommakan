
import 'package:jom_makan/database/db_connection.dart';

class Promotion {
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
      var result = await pool.execute(
        'INSERT INTO promotion (foodId, foodName, foodPrice, foodPromotion, foodStall, foodDescription)'
        ' VALUES (:foodId, :foodName, :foodPrice, :foodPromotion, :foodStall, :foodDescription)',

        {
          "foodId": foodId,
          "foodName": foodName,
          "foodPrice": foodPrice,
          "foodPromotion": foodPromotion,
          "foodStall": foodStall,
          "foodDescription": foodDescription,
        },
        
      );


      // Check if the insertion was successful
      return int.parse(result.affectedRows.toString()) == 1;
      }

      
Future<bool> deletePromotion(String foodId) async {
    try {
      // Execute the delete query
      var result = await pool.execute(
        'DELETE FROM promotion WHERE foodId = :foodId',
        {"foodId": foodId},
      );

      // Check if the deletion was successful
      return int.parse(result.affectedRows.toString()) == 1;
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error during deletion of the Promotion: $e');
      return false;
    }
  }

    // } catch (e) {
    //   // Handle database errors or other exceptions here
    //   print('Error during generate the Promotion: $e');
    //   return false;
    // }

Future<List<Map<String, dynamic>>> getPromotionData() async {
    

    // var results = await pool.execute('SELECT * FROM promotion');
var results = await pool.execute('SELECT * FROM promotion');
  

    List<Map<String, dynamic>> promotion = [];

        for (final row in results.rows) {
          promotion.add({
            'foodID': row.colByName("foodID"),
            'foodName': row.colByName("foodName"),
            'foodPrice': row.colByName("foodPrice"),
            'foodPromotion': row.colByName("foodPromotion"),
            'foodStall': row.colByName("foodStall"),
            'foodDescription': row.colByName("foodDescription"),
          });
        }

return promotion;
  }

    
  }
