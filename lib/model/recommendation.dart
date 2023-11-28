import 'dart:math';
import 'package:jom_makan/model/rating.dart';
import 'package:jom_makan/server/rating/get_ratings.dart';

// To recommend foods according to the user's ratings behaviour
class RecommendationSystem {
  List<Rating> ratings;

  // Constructor to initialize the RecommendationSystem with a list of ratings
  RecommendationSystem({required this.ratings});

  // Method to get the list of food IDs that a user has rated
  List<int> getRatedFoods(int userID) {
    return ratings
        .where((rating) => rating.userID == userID)
        .map((rating) => rating.foodID)
        .toList();
  }

  // Method to calculate the similarity between two users based on their ratings
  double calculateSimilarity(int user1, int user2) {
    List<int> user1Ratings = getRatedFoods(user1);
    List<int> user2Ratings = getRatedFoods(user2);

    // Find the food IDs that both users have rated
    List<int> commonRatings = List.from(user1Ratings)
      ..retainWhere((foodID) => user2Ratings.contains(foodID));

    if (commonRatings.isEmpty) {
      return 0.0; // No common ratings, no similarity
    }

    // Calculate the similarity using the Euclidean distance formula
    double sumOfSquares = commonRatings.fold(0, (sum, foodID) {
      int ratingUser1 = ratings.firstWhere(
        (rating) => rating.userID == user1 && rating.foodID == foodID,
      ).stars;

      int ratingUser2 = ratings.firstWhere(
        (rating) => rating.userID == user2 && rating.foodID == foodID,
      ).stars;

      return sum + pow(ratingUser1 - ratingUser2, 2).toDouble();
    });

    return 1 / (1 + sqrt(sumOfSquares));
  }

  // Method to get a list of users similar to the target user
  List<int> getSimilarUsers(int targetUser) {
    Map<int, double> userSimilarities = {};

    // Calculate similarity for each user and store in a map
    for (var rating in ratings) {
      if (rating.userID != targetUser) {
        double similarity = calculateSimilarity(targetUser, rating.userID);
        userSimilarities[rating.userID] = similarity;
      }
    }

    // Remove users with NaN similarity values
    userSimilarities.removeWhere((key, value) => value.isNaN);

    // Sort users by similarity in descending order
    return userSimilarities.keys.toList()
      ..sort((a, b) => userSimilarities[b]!.compareTo(userSimilarities[a]!));
  }

  // Method to recommend foods for a target user based on similar users' preferences
  List<int> recommendFoods(int targetUser) {
    List<int> targetUserRatings = getRatedFoods(targetUser);
    List<int> recommendedFoods = [];

    List<int> similarUsers = getSimilarUsers(targetUser);

    for (var user in similarUsers) {
      List<int> userRatings = getRatedFoods(user);

      // Find unrated foods by the target user
      List<int> unratedFoods =
          userRatings.where((foodID) => !targetUserRatings.contains(foodID)).toList();
      recommendedFoods.addAll(unratedFoods);

      // Break the loop if enough recommendations (5 in this case) are obtained
      if (recommendedFoods.length >= 5) {
        break;
      }
    }

    // Convert to a set to remove duplicates and then back to a list
    return recommendedFoods.toSet().toList();
  }
}

// Example usage
Future<void> getRecommendations() async {
  FoodRatings foodRatings = FoodRatings();
  
  // Retrieve ratings from database
  List<Rating> ratings = await foodRatings.getRatingsForRecommendation();

  // Create an instance of the RecommendationSystem
  RecommendationSystem recommendationSystem = RecommendationSystem(ratings: ratings);

  // Define the target user for whom recommendations are to be generated
  int targetUser = 4;

  // Get recommended foods for the target user
  List<int> recommendedFoods = recommendationSystem.recommendFoods(targetUser);

  // Print the recommended foods for the target user
  print('Recommended Foods for User $targetUser: $recommendedFoods');
}
