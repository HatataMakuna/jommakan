import 'package:jom_makan/database/db_connection.dart';

class GetFoods {
  // for recommendationded foods' use
  Future<List<Map<String, dynamic>>> getFoodsByIds(List<int> foodIds) async {
    try {
      if (foodIds.isEmpty) {
        return []; // If the list is empty, return an empty list of foods
      }

      // Build the SQL query to retrieve foods by food IDs
      String query = '''
        SELECT
          foods.foodID, foods.food_name, stalls.stall_name,
          foods.food_price, foods.qty_in_stock, foods.food_image
        FROM foods
        JOIN stalls ON foods.stallID = stalls.stallID
        WHERE foods.foodID IN (${foodIds.map((_) => '?').join(', ')})
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

  Future<List<Map<String, dynamic>>> getFoodsByCategory(String category) async {
    try {
      var results = await pool.execute('''
        SELECT
          foods.foodID, foods.food_name, stalls.stall_name, 
          foods.food_price, foods.qty_in_stock, foods.food_image 
        FROM foods 
        JOIN stalls ON foods.stallID = stalls.stallID 
        JOIN categories ON foods.main_category = categories.categoryID 
          OR foods.sub_category = categories.categoryID 
        WHERE categories.category_name = :category_name
      ''', {"category_name": category});

      List<Map<String, dynamic>> foodList = [];

      for (final result in results.rows) {
        foodList.add({
          "foodID": result.colByName("foodID"),
          "food_name": result.colByName("food_name"),
          "stall_name": result.colByName("stall_name"),
          "food_price": result.colByName("food_price"),
          "qty_in_stock": result.colByName("qty_in_stock"),
          "food_image": result.colByName("food_image"),
        });
      }

      return foodList;
    } catch (e) {
      print('Error while getting foods by category: $e');
      return [];
    }
  }

  // TODO: Get the category name from main and sub category of the food (use foodID as input)
  Future<Map<String, dynamic>> getCategoryNameByFoodID(int foodID) async {
    String? mainCategory, subCategory;
    try {
      // Main category
      var results = await pool.execute('''
        SELECT categories.category_name FROM foods 
        JOIN categories ON foods.main_category = categories.categoryID 
        WHERE foods.foodID = :foodID
      ''', {"foodID": foodID});

      for (final row in results.rows) {
        mainCategory = row.colByName("category_name");
      }

      // Sub category
      results = await pool.execute('''
        SELECT categories.category_name FROM foods 
        JOIN categories ON foods.sub_category = categories.categoryID 
        WHERE foods.foodID = :foodID
      ''', {"foodID": foodID});

      for (final row in results.rows) {
        subCategory = row.colByName("category_name");
      }

      return {"main_category": mainCategory, "sub_category": subCategory};
    } catch (e) {
      print('Error while getting category names: $e');
      return {"main_category": '', "sub_category": ''};
    }
  }
}