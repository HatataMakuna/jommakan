import 'package:jom_makan/database/db_connection.dart';

class GetPopularFoods {
  // get 3 most viewed foods
  Future<List<Map<String, dynamic>>> getPopularFoods() async {
    try {
      var results = await pool.execute('''
        SELECT f.*, s.stall_name FROM foods f 
        JOIN stalls s ON f.stallID = s.stallID 
        ORDER BY f.views DESC LIMIT 3
      ''');

      List<Map<String, dynamic>> foods = [];

      for (final row in results.rows) {
        foods.add({
          'foodID': row.colByName("foodID"),
          'food_name': row.colByName("food_name"),
          'stall_name': row.colByName("stall_name"),
          'food_price': row.colByName("food_price"),
          'qty_in_stock': row.colByName("qty_in_stock"),
          'food_image': row.colByName("food_image"),
        });
      }

      return foods;
    } catch (e) {
      print("Error getting popular foods: $e");
      return [];
    }
  }
}