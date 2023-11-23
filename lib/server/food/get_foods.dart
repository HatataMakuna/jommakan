import 'package:jom_makan/database/db_connection.dart';

class GetFoods {
  Future<List<Map<String, dynamic>>> getAllFoods({
    String? searchQuery, int? priceRangeMin, int? priceRangeMax,
    double? minRating, List<String>? selectedLocations, List<String>? selectedCategories,
  }) async {
    try {
      // Build the SQL query based on parameters
      String query = '''
        SELECT
          foods.foodID, foods.food_name, stalls.stall_name, 
          foods.food_price, foods.qty_in_stock, foods.food_image, 
          
        FROM foods
        JOIN stalls ON foods.stallID = stalls.stallID
        WHERE UPPER(foods.food_name) LIKE UPPER(?)
      ''';

      var stmt = await pool.prepare(query);

      // Use '%' in the query to match any substring of the food name
      String searchValue = searchQuery ?? '';
      searchValue = '%$searchValue%';

      // Execute the SQL query
      var results = await stmt.execute([searchValue]);

      // Extract and return the list of foods
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
      
      // Deallocate prepared statement
      await stmt.deallocate();

      return foods;
    } catch (e) {
      print('Error fetching foods: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getFoodsByIds(List<int> foodIds) async {
    try {
      if (foodIds.isEmpty) {
        return []; // If the list is empty, return an empty list of foods
      }

      // Build the SQL query to retrieve foods by food IDs
      String query = '''
        SELECT
          foods.foodID,
          foods.food_name,
          stalls.stall_name,
          foods.food_price,
          foods.qty_in_stock,
          foods.food_image
        FROM
          foods
        JOIN
          stalls ON foods.stallID = stalls.stallID
        WHERE
          foods.foodID IN (${foodIds.map((_) => '?').join(', ')})
      ''';

      var stmt = await pool.prepare(query);

      // Execute the SQL query with the list of food IDs
      var results = await stmt.execute(foodIds);

      // Extract and return the list of foods
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

      // Deallocate prepared statement
      await stmt.deallocate();

      return foods;
    } catch (e) {
      print('Error fetching foods by IDs: $e');
      return [];
    }
  }
}