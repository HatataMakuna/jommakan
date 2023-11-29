import 'package:jom_makan/database/db_connection.dart';
import 'package:jom_makan/server/cart/clear_cart.dart';
import 'package:jom_makan/server/payment/add_payment.dart';

class PlaceOrder {
  final ClearCart _clearCart = ClearCart();
  final AddPayment _addPayment = AddPayment();
  late int orderID;

  Future<bool> placeOrder({
    required int userID, required bool noCutlery,
    required List<Map<String, dynamic>> cartItems,
    required String paymentMethod,
    required double totalPrice,
  }) async {
    //String formattedDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());

    int? paymentID = await _addPayment.addPayment(paymentMethod: paymentMethod, totalPrice: totalPrice);
    if (paymentID == null) {
      print('An error occurred while processing your order');
      return false;
    }

    try {
      // Insert into the orders table
      var result = await pool.execute('''
        INSERT INTO orders (userID, noCutlery, paymentID, total_price) 
        VALUES (:userID, :noCutlery, :payment, :total_price)
      ''', {
        "userID": userID,
        "noCutlery": noCutlery ? 1 : 0,
        "payment": paymentID,
        "total_price": totalPrice,
      });

      // Get the last order ID
      orderID = result.lastInsertID.toInt();

      // Insert into the order_details table
      for (var cartItem in cartItems) {
        bool noVege, extraVege, noSpicy, extraSpicy;
        if (cartItem['no_vege'] == 1) {
          noVege = true;
        } else {
          noVege = false;
        }
        print(noVege);

        if (cartItem['extra_vege'] == 1) {
          extraVege = true;
        } else {
          extraVege = false;
        }
        print(extraVege);

        if (cartItem['no_spicy'] == 1) {
          noSpicy = true;
        } else {
          noSpicy = false;
        }
        print(noSpicy);

        if (cartItem['extra_spicy'] == 1) {
          extraSpicy = true;
        } else {
          extraSpicy = false;
        }
        print(extraSpicy);

        await pool.execute('''
          INSERT INTO order_details (orderID, foodID, quantity, price, no_vege, extra_vege, no_spicy, extra_spicy, notes) 
          VALUES (:orderID, :foodID, :quantity, :price, :no_vege, :extra_vege, :no_spicy, :extra_spicy, :notes)
        ''', {
          "orderID": orderID,
          "foodID": cartItem['foodID'],
          "quantity": cartItem['quantity'],
          "price": double.parse(cartItem['food_price']) * double.parse(cartItem['quantity']),
          "no_vege": noVege ? 1 : 0,
          "extra_vege": extraVege ? 1 : 0,
          "no_spicy": noSpicy ? 1 : 0,
          "extra_spicy": extraSpicy ? 1 : 0,
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

/* void main() {
  BigInt test = BigInt.from(1);
  int intTest = test.toInt();

  print(intTest);
} */

/*
  cart (cartID, userID, foodID, quantity, no_vege, extra_vege, no_spicy, extra_spicy, notes)
  orders (orderID, userID, noCutlery, status, payment, date)
  order_details (odetailsID, orderID, foodID, quantity, price, no_vege, extra_vege, no_spicy, extra_spicy, notes)
*/