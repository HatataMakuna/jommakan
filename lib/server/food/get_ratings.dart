import 'package:jom_makan/database/db_connection.dart';
import 'package:mysql1/mysql1.dart';

class FoodRatings {
  final MySqlConnectionPool _connectionPool;

  FoodRatings(this._connectionPool);

  Future<List<int>> getRatingsForFood(String foodName, String stallName) async {
    MySqlConnection? conn;

    try {
      conn = await _connectionPool.getConnection();

      // Retrieve ratings for the given food name and stall name
      var results = await conn.query(
        'SELECT stars FROM ratings '
        'INNER JOIN foods ON ratings.foodID = foods.foodID '
        'INNER JOIN stalls ON foods.stallID = stalls.stallID '
        'WHERE foods.food_name = ? AND stalls.stall_name = ?',
        [foodName, stallName],
      );

      // Extract and return the ratings
      List<int> ratings = results.map((result) => result['stars'] as int).toList();

      return ratings;
    } catch (e) {
      print('Error retrieving ratings: $e');
      return [];
    } finally {
      // Release the connection back to the pool
      await conn?.close();
    }
  }

  double calculateAverageRating(List<int> ratings) {
    if (ratings.isEmpty) {
      // Return a default value (e.g., 0) if there are no ratings
      return 0.0;
    }

    // Calculate the sum of ratings
    int sum = ratings.reduce((value, element) => value + element);

    // Calculate the average rating
    double averageRating = sum / ratings.length;

    // Round to 1 decimal place (adjust as needed)
    return double.parse(averageRating.toStringAsFixed(1));
  }
}
