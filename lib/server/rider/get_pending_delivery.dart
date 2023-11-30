import 'package:jom_makan/database/db_connection.dart';

class GetPendingDelivery {
  Future<List<Map<String, dynamic>>> getPendingDeliveries() async {
    try {
      var results = await pool.execute('''
        SELECT o.orderID, u.username, COUNT(od.foodID) as foodCount, d.orderedOn 
        FROM orders o 
        JOIN users u ON o.userID = u.userID 
        JOIN order_details od ON o.orderID = od.orderID 
        JOIN delivery d ON o.orderID = d.orderID 
        WHERE d.status = 'Pending' AND o.order_method = 'Delivery' 
        GROUP BY o.orderID
      ''');

      List<Map<String, dynamic>> pendingDelivery = [];

      for (final row in results.rows) {
        pendingDelivery.add({
          "orderID": row.colByName("orderID"),
          "username": row.colByName("username"),
          "foodCount": row.colByName("foodCount"),
          "orderedOn": row.colByName("orderedOn"),
        });
      }

      return pendingDelivery;
    } catch (e) {
      print('Error while getting pending deliveries: $e');
      return [];
    }
  }
}

/*
  Database schema:
  delivery (deliveryID, orderID, address, status)
  orders (orderID, userID, noCutlery, status, paymentID, total_price, order_method)
  order_details (odetailsID, orderID, foodID, quantity, price, no_vege, extra_vege, no_spicy, extra_spicy, notes)
  users (userID, username, email, password, user_role)

  orderID, username, foodCount (counts the number of foods ordered from order_details that have that same order ID), orderedOn
*/