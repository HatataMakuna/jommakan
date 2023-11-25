import 'package:intl/intl.dart';
import 'package:jom_makan/database/db_connection.dart';

class AddOrModifyReview {
  Future<bool> addReview(int foodID, int userID, double stars, String description) async {
    String formattedDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());

    try {
      var stmt = await pool.prepare('''
        INSERT INTO ratings (foodID, userID, stars, date, description) 
        VALUES (?, ?, ?, ?, ?)
      ''');

      var result = await stmt.execute([foodID, userID, stars.toInt(), formattedDate, description]);

      await stmt.deallocate();
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print('Error adding review: $e');
      return false;
    }
  }

  Future<bool> updateReview(double stars, String description, int ratingID) async {
    try {
      var stmt = await pool.prepare('''
        UPDATE ratings 
        SET stars = ?, date = NOW(), description = ? 
        WHERE ratingID = ?
      ''');

      var result = await stmt.execute([stars.toInt(), description, ratingID]);

      await stmt.deallocate();
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print('Error updating review: $e');
      return false;
    }
  }
}