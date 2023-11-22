import 'package:jom_makan/database/db_connection.dart';

class ModifyRemoveCart {
  Future<bool> modifyCart({
    required int cartID,
    required int newQuantity,
    required List<String>? newPreferences,
    required String? newNotes,
  }) async {
    try {
      var stmt = await pool.prepare('''
        UPDATE cart
        SET quantity = ?, no_vege = ?, extra_vege = ?, no_spicy = ?, extra_spicy = ?, notes = ?
        WHERE cartID = ?
      ''');

      var result = await stmt.execute([
        newQuantity,
        newPreferences!.contains('no vegetarian') ? 1 : 0,
        newPreferences.contains('extra vegetarian') ? 1 : 0,
        newPreferences.contains('no spicy') ? 1 : 0,
        newPreferences.contains('extra spicy') ? 1 : 0,
        newNotes, cartID
      ]);

      await stmt.deallocate();
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print('Error modifying cart item: $e');
      return false;
    }
  }

  Future<bool> removeFromCart({required int cartID}) async {
    try {
      var stmt = await pool.prepare('DELETE FROM cart WHERE cartID = ?');
      var result = await stmt.execute([cartID]);
      await stmt.deallocate();
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print('Error deleting cart item: $e');
      return false;
    }
  }
}

/*
  Database schema:
  cart (cartID, userID, foodID, quantity, no_vege, extra_vege, no_spicy, extra_spicy, notes)
*/