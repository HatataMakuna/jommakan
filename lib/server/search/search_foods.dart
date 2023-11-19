import 'package:jom_makan/database/db_connection.dart';
import 'package:mysql1/mysql1.dart';

class SearchFoods {
  final MySqlConnectionPool _connectionPool;

  SearchFoods(this._connectionPool);

  Future<List<Map<String, dynamic>>> getFoods(String searchQuery) async {
    MySqlConnection? conn;

    try {
      conn = await _connectionPool.getConnection();
      print(searchQuery);

      // Execute the SQL query to get foods based on the search query
      var results = await conn.query(
        '''
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
        ''',
        [searchQuery],
      );

      // If there are results, return them
      if (results.isNotEmpty) {
        return List<Map<String, dynamic>>.from(results);
      } else {
        // If no results found, return an empty list
        return [];
      }
    } catch (e) {
      print('Error retrieving foods: $e');
      // Handle the error as needed
      return [];
    } finally {
      // Release the connection back to the pool
      await conn?.close();
    }
  }

  void main() async {
    // Example of how to use the SearchFoods
    final searchFoods = SearchFoods(MySqlConnectionPool());

    // Replace 'Burger' with your actual search query
    final foods = await searchFoods.getFoods('rice');

    // Print the results (you can handle them as needed)
    print(foods);
  }
}
