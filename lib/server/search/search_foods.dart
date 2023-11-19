import 'package:jom_makan/database/db_connection.dart';

class SearchFoods {
  Future<List<Map<String, dynamic>>> getFoods(String searchQuery) async {
    try {
      // Execute the SQL query to get foods based on the search query
      var stmt = await pool.prepare(
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
        '''
      );

      String searchValue = '%$searchQuery%';
      var results = await stmt.execute([searchValue]);

      if (results.isNotEmpty) {
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

        await stmt.deallocate();
        return foods;
      } else {
        // Not found
        return [];
      }
    } catch (e) {
      print('Error retrieving foods: $e');
      // Handle the error as needed
      return [];
    }
  }

  /* void main() async {
    // Example of how to use the SearchFoods
    final searchFoods = SearchFoods();

    // Replace 'Burger' with your actual search query
    final foods = await searchFoods.getFoods('rice');

    // Print the results (you can handle them as needed)
    print(foods);
  } */
}
