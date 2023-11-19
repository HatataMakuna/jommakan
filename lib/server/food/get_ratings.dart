import 'package:jom_makan/database/db_connection.dart';

class FoodRatings {
  Future<List<int>> getRatingsForFood(int foodID) async {
    try {
      var stmt = await pool.prepare('''
        SELECT stars 
        FROM ratings 
        WHERE foodID = ?
      ''');

      // Retrieve ratings for the given food name and stall name
      var results = await stmt.execute([foodID]);

      // Extract and return the ratings
      List<int> ratings = [];
      for (final row in results.rows) {
        ratings.add(row.colByName("stars") as int);
      }

      await stmt.deallocate();
      return ratings;
    } catch (e) {
      print('Error retrieving ratings: $e');
      return [];
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

void main() async {
    // Example of how to use the SearchFoods
    final getratings = FoodRatings();

    // Replace 'Burger' with your actual search query
    final foods = await getratings.getRatingsForFood(1);

    // Print the results (you can handle them as needed)
    print(foods);
}
