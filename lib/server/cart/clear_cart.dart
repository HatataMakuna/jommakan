import 'package:jom_makan/database/db_connection.dart';

class ClearCart {
  Future<void> clearCart(int userID) async {
    try {
      await pool.execute("DELETE FROM cart WHERE userID = :userID", {"userID": userID});
    } catch (e) {
      print('Error while clearing cart: $e');
    }
  }
}