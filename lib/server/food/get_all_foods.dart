import 'package:jom_makan/database/db_connection.dart';

class GetAllFoods {
  Future<List<Map<String, dynamic>>> getAllFoods() async {
    try {
      String query = '''
        SELECT
          foods.foodID, foods.food_name, stalls.stall_name, 
          foods.food_price, foods.qty_in_stock, foods.food_image 
            
        FROM foods
        JOIN stalls ON foods.stallID = stalls.stallID
      ''';

      var results = await pool.execute(query);

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
      print('Error fetching foods: $e');
      return [];
    }
  }
}