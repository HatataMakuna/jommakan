import 'package:jom_makan/database/db_connection.dart';

class AddToCart {
  Future<bool> addToCart({
    required int userID,
    required int foodID,
    required int quantity,
    required bool noVege,
    required bool extraVege,
    required bool noSpicy,
    required bool extraSpicy,
    required String notes,
  }) async {
    try {
      // Map boolean values to 0 or 1
      int noVegeInt = noVege ? 1 : 0;
      int extraVegeInt = extraVege ? 1 : 0;
      int noSpicyInt = noSpicy ? 1 : 0;
      int extraSpicyInt = extraSpicy ? 1 : 0;

      // Insert the cart item into the database
      var result = await pool.execute(
        'INSERT INTO cart (userID, foodID, quantity, no_vege, extra_vege, no_spicy, extra_spicy, notes) '
        'VALUES (:userID, :foodID, :quantity, :noVege, :extraVege, :noSpicy, :extraSpicy, :notes)',
        {
          "userID": userID,
          "foodID": foodID,
          "quantity": quantity,
          "noVege": noVegeInt,
          "extraVege": extraVegeInt,
          "noSpicy": noSpicyInt,
          "extraSpicy": extraSpicyInt,
          "notes": notes,
        },
      );

      return result.affectedRows.toInt() == 1; // Check if the insertion was successful
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error during adding to cart: $e');
      return false;
    }
  }
}

/*
  Database schema:
  cartID, userID, foodID, quantity, no_vege, extra_vege, no_spicy, extra_spicy, notes

  no_vege to extra_spicy: true or false
*/