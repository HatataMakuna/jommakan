import 'package:jom_makan/database/db_connection.dart';
import 'package:jom_makan/model/rating.dart';

class FoodRatings {
  Future<double> getAverageRatings(int foodID) async {
    try {
      var results = await pool.execute("SELECT stars FROM ratings WHERE foodID = :foodID", {"foodID": foodID});

      List<int> ratings = [];
      int sum = 0;
      for (final row in results.rows) {
        sum += int.parse(row.colByName("stars").toString());
        print('Current Sum: ' + sum.toString());
      }

      if (ratings.isEmpty) {
        return 0.0;
      }

      double averageRating = sum / ratings.length;
      print('Avergae Rating: ' + averageRating.toString());
      return averageRating;
    } catch (e) {
      print('Error retrieving ratings: $e');
      return 0.0;
    }
  }

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
        ratings.add(int.parse(row.colByName("stars").toString()));
      }

      await stmt.deallocate();
      return ratings;
    } catch (e) {
      print('Error retrieving ratingss: $e');
      return [];
    }
  }

  Future<int> getNumberOfRatings(int foodID) async {
    try {
      int noRatings = 0;
      var results = await pool.execute("SELECT COUNT(stars) FROM ratings WHERE foodID = :foodID", {'foodID': foodID});

      for (final row in results.rows) {
        noRatings = int.parse(row.colAt(0).toString());
      }

      return noRatings;
    } catch (e) {
      print('Error retrieving number of ratings: $e');
      return 0;
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

  Future<List<Rating>> getRatingsForRecommendation() async {
    try {
      var results = await pool.execute("SELECT ratingID, foodID, userID, stars FROM ratings");
      List<Rating> ratings = [];

      for (final row in results.rows) {
        ratings.add(Rating(
          ratingID: int.parse(row.colByName("ratingID").toString()),
          foodID: int.parse(row.colByName("foodID").toString()),
          userID: int.parse(row.colByName("userID").toString()),
          stars: int.parse(row.colByName("stars").toString()),
        ));
      }

      return ratings;
    } catch (e) {
      print('Error retrieving list of ratings: $e');
      return [];
    }
  }
}

void main() async {
    // Example of how to use the SearchFoods
    final getratings = FoodRatings();

    final foods = await getratings.getRatingsForFood(1);

    // Print the results
    print(foods);
}
