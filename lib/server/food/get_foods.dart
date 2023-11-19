import 'package:mysql1/mysql1.dart';
import 'package:jom_makan/database/db_connection.dart';

class GetFoods {
  final MySqlConnectionPool _connectionPool;

  GetFoods(this._connectionPool);

  Future<List<Map<String, dynamic>>> getAllFoods({
    String? searchQuery,
    int? priceRangeMin,
    int? priceRangeMax,
    double? minRating,
    List<String>? selectedLocations,
    List<String>? selectedCategories,
  }) async {
    MySqlConnection? conn;

    try {
      conn = await _connectionPool.getConnection();

      // Build the SQL query based on parameters
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
          UPPER(foods.food_name) LIKE UPPER(?)
      ''';

      // Use '%' in the query to match any substring of the food name
      String searchValue = searchQuery ?? '';
      searchValue = '%$searchValue%';

      // Execute the SQL query
      var results = await conn.query(query, [searchValue]);

      // Extract and return the list of foods
      List<Map<String, dynamic>> foods = results.map((result) {
        return {
          'foodID': result['foodID'],
          'food_name': result['food_name'],
          'stall_name': result['stall_name'],
          'food_price': result['food_price'],
          'qty_in_stock': result['qty_in_stock'],
          'food_image': result['food_image'],
        };
      }).toList();

      return foods;
    } catch (e) {
      print('Error fetching foods: $e');
      return [];
    } finally {
      // Release the connection back to the pool
      await conn?.close();
    }
  }
}
