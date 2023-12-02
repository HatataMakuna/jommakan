import 'package:jom_makan/database/db_connection.dart';

class Favorites {
  Future<bool> addToFavorites({required int userID, required int foodID}) async {
    try {
      var result = await pool.execute(
        "INSERT INTO favorites (userID, foodID) VALUES (:userID, :foodID)",
        {"userID": userID, "foodID": foodID}
      );

      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print('Error while adding to favorites: $e');
      return false;
    }
  }

  Future<bool> removeFromFavorites({required int userID, required int foodID}) async {
    try {
      var result = await pool.execute(
        "DELETE FROM favorites WHERE userID = :userID AND foodID = :foodID",
        {"userID": userID, "foodID": foodID}
      );

      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print('Error while removing from favorites: $e');
      return false;
    }
  }

  Future<List<int>> getUserFavorites({required int userID}) async {
    try {
      var results = await pool.execute("SELECT foodID FROM favorites WHERE userID = :userID", {"userID": userID});

      List<int> favoritesList = [];

      for (final result in results.rows) {
        favoritesList.add(int.parse(result.colByName("foodID")!));
      }

      return favoritesList;
    } catch (e) {
      print('Error while getting user favorites: $e');
      return [];
    }
  }
}