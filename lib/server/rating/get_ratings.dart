import 'package:jom_makan/database/db_connection.dart';
import 'package:jom_makan/model/rating.dart';

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

  Future<List<Map<String, dynamic>>> getUserReviews(int foodID, int userID) async {
    try {
      String query = '''
        SELECT users.username, ratings.stars, ratings.description
        FROM ratings
        JOIN users ON ratings.userID = users.userID
        WHERE ratings.foodID = :foodID
        ORDER BY ratings.userID = :userID DESC, ratings.date DESC;
      ''';

      var results = await pool.execute(query, {"foodID": foodID, "userID": userID});
      List<Map<String, dynamic>> reviews = [];

      for (final row in results.rows) {
        reviews.add({
          'username': row.colByName("username"),
          'stars': row.colByName("stars"),
          'description': row.colByName("description"),
        });
      }

      return reviews;
    } catch (e) {
      print('Error retrieving user reviews: $e');
      return [];
    }
  }

  // Get current user review
  Future<Map<String, dynamic>?> getCurrentUserReview(int foodID, int userID) async {
    try {
      String query = '''
        SELECT ratingID, stars, description
        FROM ratings
        WHERE foodID = :foodID AND userID = :userID;
      ''';

      var results = await pool.execute(query, {"foodID": foodID, "userID": userID});

      if (results.rows.isNotEmpty) {
        final row = results.rows.first;
        return {
          'ratingID': row.colByName("ratingID"),
          'stars': row.colByName("stars"),
          'description': row.colByName("description"),
        };
      }

      return null; // Return null if the user hasn't reviewed the food
    } catch (e) {
      print('Error retrieving current user review: $e');
      return null;
    }
  }
}

/*
  Database schema:
  ratings(ratingID, foodID, userID, stars, date, description)
  users(userID, username, email, password, user_role)
*/

void main() async {
  // Example of how to use the SearchFoods
  final getratings = FoodRatings();

  final foods = await getratings.getRatingsForFood(1);

  // Print the results
  print(foods);
}
