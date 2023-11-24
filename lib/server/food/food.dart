import 'package:jom_makan/database/db_connection.dart';



class Food {
  Future<bool> foodRegister({
    required String foodID,
    // ignore: non_constant_identifier_names
    required String food_name,
        // ignore: non_constant_identifier_names
    required String stallID,
        // ignore: non_constant_identifier_names
    required String main_category,
        // ignore: non_constant_identifier_names
    required String sub_category,
        // ignore: non_constant_identifier_names
    required String food_price,
        // ignore: non_constant_identifier_names
    required String qty_in_stock,
        // ignore: non_constant_identifier_names
    required String food_image,
  })async{
   // Insert new user to the database
      var result = await pool.execute(
        'INSERT INTO foods (foodID, food_name, stallID, main_category, sub_Category, food_price, qty_in_stock, food_image)'
        ' VALUES (:foodID, :food_name, :stallID, :main_category, :sub_category, :food_price, :qty_in_stock, :food_image)',

        {
          "foodID": foodID,
          "food_name": food_name,
          "stallID": stallID,
          "main_category": main_category,
          "sub_category": sub_category,
          "food_price": food_price,
          "qty_in_stock": qty_in_stock,
          "food_image": food_image,
        },
        
      );


      // Check if the insertion was successful
      return int.parse(result.affectedRows.toString()) == 1;
      }

Future<bool> deleteFood(String foodID) async {
    try {
      // Execute the delete query
      var result = await pool.execute(
        'DELETE FROM foods WHERE foodID = :foodID',
        {"foodID": foodID},
      );

      // Check if the deletion was successful
      return int.parse(result.affectedRows.toString()) == 1;
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error during deletion of the Food: $e');
      return false;
    }
  }




    // } catch (e) {
    //   // Handle database errors or other exceptions here
    //   print('Error during generate the Promotion: $e');
    //   return false;
    // }

Future<List<Map<String, dynamic>>> getFoodData() async {
    

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
          });
        }

return food;
  }

    
  }
