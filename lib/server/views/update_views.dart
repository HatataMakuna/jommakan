import 'package:jom_makan/database/db_connection.dart';

class UpdateViews {
  static Future<void> updateViewCount(int foodID) async {
    try {
      await pool.execute(
        "UPDATE foods SET views = views + 1 WHERE foodID = :foodID",
        {"foodID": foodID}
      );
      print('View updated to food: ' + foodID.toString());
    } catch (e) {
      print("Error while updating view count: $e");
    }
  }
}