import 'package:jom_makan/database/db_connection.dart';

class Food {
  // add food to database
  Future<bool> foodRegister({
    required String foodName, required int stallID,
    required int mainCategory, required int subCategory, required double foodPrice,
    required int qtyInStock, required String foodImage, 
  }) async{
    try {
      var result = await pool.execute(
        '''
        INSERT INTO foods 
        (food_name, stallID, main_category, sub_Category, food_price, qty_in_stock, food_image) 
        VALUES 
        (:food_name, :stallID, :main_category, :sub_category, :food_price, :qty_in_stock, :food_image)
        ''',
        {
          "food_name": foodName,
          "stallID": stallID,
          "main_category": mainCategory,
          "sub_category": subCategory,
          "food_price": foodPrice,
          "qty_in_stock": qtyInStock,
          "food_image": foodImage,
        },
      );

      // Check if the insertion was successful
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print("Error while adding food to database: $e");
      return false;
    }
  }

  // delete food from database
  Future<bool> deleteFood(String foodID) async {
    try {
      // Execute the delete query
      var result = await pool.execute(
        'DELETE FROM foods WHERE foodID = :foodID', {"foodID": foodID},
      );

      // Check if the deletion was successful
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print('Error while deleting food: $e');
      return false;
    }
  }

  // retrieve food from database (display in admin portal)
  Future<List<Map<String, dynamic>>> getFoodData() async {
    try {
      var results = await pool.execute('SELECT * FROM foods');

      List<Map<String, dynamic>> food = [];

      for (final row in results.rows) {
        food.add({
          'foodID': row.colByName("foodID"),
          'food_name': row.colByName("food_name"),
          'stallID': row.colByName("stallID"),
          'main_category': row.colByName("main_category"),
          'sub_category': row.colByName("sub_category"),
          'food_price': row.colByName("food_price"),
          'qty_in_stock': row.colByName("qty_in_stock"),
          'food_image': row.colByName("food_image"),
          'views': row.colByName("views"),
        });
      }
      return food;
    } catch (e) {
      print("Error while retrieving foods: $e");
      return [];
    }
  }  
  
  Future<bool> updateQuantity(String foodID, int newQuantity) async {
    try {
      var result = await pool.execute(
        'UPDATE foods SET qty_in_stock = :newQuantity WHERE foodID = :foodID',
        {
          "newQuantity": newQuantity,
          "foodID": foodID,
        },
      );

      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print('Error while updating quantity: $e');
      return false;
    }
  }
}

