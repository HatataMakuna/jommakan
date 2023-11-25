import 'package:jom_makan/database/db_connection.dart';

class Promotion {
  Future<bool> promotionRegister({
    required String foodId, required String foodName, required String foodPrice,
    required String foodPromotion, required String foodStall, required String foodDescription,
  }) async {
    try {
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
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print("Error while adding promotion: $e");
      return false;
    }
  }

  Future<bool> deletePromotion(String foodId) async {
    try {
      // Execute the delete query
      var result = await pool.execute(
        'DELETE FROM promotion WHERE foodId = :foodId', {"foodId": foodId},
      );

      // Check if the deletion was successful
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error while deleting promotion: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getPromotionData() async {
    try {
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
    } catch (e) {
      print("Error while getting promotion data: $e");
      return [];
    }
  }
}