import 'package:jom_makan/database/db_connection.dart';

class EditStock {
  void editStock({required int foodID, required int quantity}) async {
    try {
      await pool.execute('''
        UPDATE foods SET qty_in_stock = qty_in_stock - :quantity WHERE foodID = :foodID
      ''', {
        "quantity": quantity,
        "foodID": foodID
      });
    } catch (e) {
      print('Error while editing food stock: $e');
    }
  }
}