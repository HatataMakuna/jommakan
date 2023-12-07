import 'package:jom_makan/database/db_connection.dart';

class GetOrders {
  // Display the odetailsID, date, food image, food name, price, quantity, payment method, status
  Future<List<Map<String, dynamic>>> getAllOrders(int userID) async {
    try {
      String query = '''
        SELECT
          od.odetailsID, f.food_image, f.food_name, od.price, od.quantity, 
          o.status, od.no_vege, od.extra_vege, od.no_spicy, od.extra_spicy, 
          od.notes, p.payment_date, p.payment_method, o.seatqr_bytes 
        FROM order_details od 
        JOIN foods f ON od.foodID = f.foodID
        JOIN orders o ON od.orderID = o.orderID
        JOIN payments p ON o.paymentID = p.paymentID
        WHERE o.userID = :userID
        ORDER BY od.odetailsID DESC;
      ''';
      var results = await pool.execute(query, {"userID": userID});

      List<Map<String, dynamic>> orderItems = [];
      for (final row in results.rows) {
        orderItems.add({
          'odetailsID': row.colByName("odetailsID"),
          'food_image': row.colByName("food_image"),
          'food_name': row.colByName("food_name"),
          'price': row.colByName("price"),
          'quantity': row.colByName("quantity"),
          'status': row.colByName("status"),
          'no_vege': row.colByName("no_vege"),
          'extra_vege': row.colByName("extra_vege"),
          'no_spicy': row.colByName("no_spicy"),
          'extra_spicy': row.colByName("extra_spicy"),
          'notes': row.colByName("notes"),
          'date': row.colByName("payment_date"),
          'payment': row.colByName("payment_method"),
          'seatqr_bytes': row.colByName("seatqr_bytes"),
        });
      }
      
      return orderItems;
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error while getting cart details: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getOrderDetailsByOrderID(int orderID) async {
    try {
      String query = '''
        SELECT
          od.odetailsID, f.food_image, f.food_name, od.price, od.quantity, od.no_vege, 
          od.extra_vege, od.no_spicy, od.extra_spicy, od.notes, s.stall_name 
        FROM order_details od 
        JOIN foods f ON od.foodID = f.foodID 
        JOIN stalls s ON f.stallID = s.stallID 
        WHERE od.orderID = :orderID
      ''';
      var results = await pool.execute(query, {"orderID": orderID});

      List<Map<String, dynamic>> orderDetails = [];
      for (final row in results.rows) {
        String notes = '';
        if (row.colByName("notes") != null) {
          notes = row.colByName("notes")!;
        }

        orderDetails.add({
          'odetailsID': row.colByName("odetailsID"),
          'food_image': row.colByName("food_image"),
          'food_name': row.colByName("food_name"),
          'price': row.colByName("price"),
          'quantity': row.colByName("quantity"),
          'no_vege': row.colByName("no_vege"),
          'extra_vege': row.colByName("extra_vege"),
          'no_spicy': row.colByName("no_spicy"),
          'extra_spicy': row.colByName("extra_spicy"),
          'notes': notes,
          'stall_name': row.colByName("stall_name"),
        });
      }

      return orderDetails;
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error while getting order details: $e');
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