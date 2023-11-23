import 'package:jom_makan/database/db_connection.dart';

class GetOrders {
  // Display the odetailsID, date, food image, food name, price, quantity, payment method, status
  Future<List<Map<String, dynamic>>> getAllOrders(int userID) async {
    try {
      String query = '''
        SELECT
          od.odetailsID, o.date, f.food_image, f.food_name, 
          od.price, od.quantity, o.payment, o.status, 
          od.no_vege, od.extra_vege, od.no_spicy, od.extra_spicy, od.notes
        FROM order_details od 
        JOIN foods f ON od.foodID = f.foodID
        JOIN orders o ON od.orderID = o.orderID
        WHERE o.userID = :userID
      ''';
      var results = await pool.execute(query, {"userID": userID});

      List<Map<String, dynamic>> orderItems = [];
      for (final row in results.rows) {
        orderItems.add({
          'odetailsID': row.colByName("odetailsID"),
          'date': row.colByName("date"),
          'food_image': row.colByName("food_image"),
          'food_name': row.colByName("food_name"),
          'price': row.colByName("price"),
          'quantity': row.colByName("quantity"),
          'payment': row.colByName("payment"),
          'status': row.colByName("status"),
          'no_vege': row.colByName("no_vege"),
          'extra_vege': row.colByName("extra_vege"),
          'no_spicy': row.colByName("no_spicy"),
          'extra_spicy': row.colByName("extra_spicy"),
          'notes': row.colByName("notes"),
        });
      }
      
      return orderItems;
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error while getting cart details: $e');
      return [];
    }
  }
}

/*
  Database schema:
  orders (orderID, userID, noCutlery, status, payment, date)
  order_details (odetailsID, orderID, foodID, quantity, price, no_vege, extra_vege, no_spicy, extra_spicy, notes)
  foods (foodID, food_name, stallID, main_category, sub_category)
*/