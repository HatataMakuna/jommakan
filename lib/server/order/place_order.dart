import 'package:jom_makan/database/db_connection.dart';
import 'package:intl/intl.dart';
import 'package:jom_makan/server/cart/clear_cart.dart';

class PlaceOrder {
  final ClearCart _clearCart = ClearCart();

  Future<bool> placeOrder({
    required int userID, required bool noCutlery,
    required String payment, required List<Map<String, dynamic>> cartItems,
  }) async {
    String formattedDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());

    try {
      // Insert into the orders table
      var result = await pool.execute('''
        INSERT INTO orders (userID, noCutlery, payment, date) 
        VALUES (:userID, :noCutlery, :payment, :date)
      ''', {
        "userID": userID,
        "noCutlery": noCutlery ? 1 : 0,
        "payment": payment,
        "date": formattedDate,
      });

      // Get the last order ID
      int? orderID = result.lastInsertID as int?;

      // Insert into the order_details table
      for (var cartItem in cartItems) {
        await pool.execute('''
          INSERT INTO order_details (orderID, foodID, quantity, price, no_vege, extra_vege, no_spicy, extra_spicy, notes) 
          VALUES (:orderID, :foodID, :quantity, :price, :no_vege, :extra_vege, :no_spicy, :extra_spicy, :notes)
        ''', {
          "orderID": orderID,
          "foodID": cartItem['foodID'],
          "quantity": cartItem['quantity'],
          "price": cartItem['price'],
          "no_vege": cartItem['no_vege'] ? 1 : 0,
          "extra_vege": cartItem['extra_vege'] ? 1 : 0,
          "no_spicy": cartItem['no_spicy'] ? 1 : 0,
          "extra_spicy": cartItem['extra_spicy'] ? 1 : 0,
          "notes": cartItem['notes']
        });
      }

      // clear the user cart after placing the order
      await _clearCart.clearCart(userID);

      return true;
    } catch (e) {
      print('Error while placing order: $e');
      return false;
    }
  }
}

/*
  cart (cartID, userID, foodID, quantity, no_vege, extra_vege, no_spicy, extra_spicy, notes)
  orders (orderID, uesrID, noCutlery, status, payment, date)
  order_details (odetailsID, orderID, foodID, quantity, price, no_vege, extra_vege, no_spicy, extra_spicy, notes)
*/