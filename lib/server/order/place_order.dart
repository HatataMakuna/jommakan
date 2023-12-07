import 'dart:convert';
import 'dart:typed_data';

import 'package:jom_makan/database/db_connection.dart';
import 'package:jom_makan/server/cart/clear_cart.dart';
import 'package:jom_makan/server/food/edit_stock.dart';
import 'package:jom_makan/server/payment/add_payment.dart';
import 'package:jom_makan/server/seat_display/seat_display.dart';

class PlaceOrder {
  final ClearCart _clearCart = ClearCart();
  final AddPayment _addPayment = AddPayment();
  final SeatDisplay _seatDisplay = SeatDisplay();
  final EditStock _editStock = EditStock();
  late int orderID;

  Future<bool> placeOrder({
    required int userID, required bool noCutlery,
    required List<Map<String, dynamic>> cartItems,
    required String paymentMethod,
    required double totalPrice,
    required String orderMethod,
    required List<Map<String, dynamic>> selectedSeats,
    required Uint8List seatQrBytes,
  }) async {
    //String formattedDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());

    int? paymentID = await _addPayment.addPayment(paymentMethod: paymentMethod, totalPrice: totalPrice);
    if (paymentID == null) {
      print('An error occurred while processing your order');
      return false;
    }

    try {
      String seatQrBytesBase64 = base64Encode(seatQrBytes);
      
      // Insert into the orders table
      var result = await pool.execute('''
        INSERT INTO orders (userID, noCutlery, paymentID, total_price, order_method, seatqr_bytes) 
        VALUES (:userID, :noCutlery, :payment, :total_price, :order_method, :seatqr_bytes)
      ''', {
        "userID": userID,
        "noCutlery": noCutlery ? 1 : 0,
        "payment": paymentID,
        "total_price": totalPrice,
        "order_method": orderMethod,
        "seatqr_bytes": seatQrBytesBase64,
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

        if (cartItem['extra_vege'] == 1) {
          extraVege = true;
        } else {
          extraVege = false;
        }

        if (cartItem['no_spicy'] == 1) {
          noSpicy = true;
        } else {
          noSpicy = false;
        }

        if (cartItem['extra_spicy'] == 1) {
          extraSpicy = true;
        } else {
          extraSpicy = false;
        }

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

        // Deduct the quantity in stock
        _editStock.editStock(foodID: int.parse(cartItem['foodID']), quantity: int.parse(cartItem['quantity']));
      }

      // Add the selected seats to database
      for (var seat in selectedSeats) {
        _seatDisplay.seatAdded(
          confirmationID: seat['confirmationID'],
          row: seat['row'],
          col: seat['col'],
          location: seat['location'],
          time: seat['time'],
          orderID: orderID,
        );
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