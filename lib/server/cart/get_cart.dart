import 'package:jom_makan/database/db_connection.dart';

class GetCart {
  Future<List<Map<String, dynamic>>> getCart(int userID) async {
    try {
      String query = '''
        SELECT
          c.cartID,
          f.food_name,
          c.quantity,
          c.no_vege,
          c.extra_vege,
          c.no_spicy,
          c.extra_spicy,
          c.notes,
          f.food_image,
          f.food_price,
          s.stall_name 
        FROM cart c
        JOIN foods f ON c.foodID = f.foodID
        JOIN stalls s ON f.stallID = s.stallID
        WHERE c.userID = :userID
      ''';
      var results = await pool.execute(query, {"userID": userID});

      List<Map<String, dynamic>> cartItems = [];

      for (final row in results.rows) {
        cartItems.add({
          'cartID': row.colByName("cartID"),
          'food_name': row.colByName("food_name"),
          'quantity': row.colByName("quantity"),
          'no_vege': row.colByName("no_vege"),
          'extra_vege': row.colByName("extra_vege"),
          'no_spicy': row.colByName("no_spicy"),
          'extra_spicy': row.colByName("extra_spicy"),
          'notes': row.colByName("notes"),
          'food_image': row.colByName("food_image"),
          'food_price': row.colByName("food_price"),
        });
      }

      return cartItems;
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error while getting cart details: $e');
      return [];
    }
  }
}