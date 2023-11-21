// TODO: Add more comments for this file

import 'dart:math';
import 'package:jom_makan/model/rating.dart';
import 'package:jom_makan/server/food/get_ratings.dart';

// To recommend foods according to the user's ratings behaviour
class RecommendationSystem {
  List<Rating> ratings;

  RecommendationSystem({required this.ratings});

  List<int> getRatedFoods(int userID) {
    return ratings
        .where((rating) => rating.userID == userID)
        .map((rating) => rating.foodID)
        .toList();
  }

  double calculateSimilarity(int user1, int user2) {
    List<int> user1Ratings = getRatedFoods(user1);
    List<int> user2Ratings = getRatedFoods(user2);

    List<int> commonRatings = List.from(user1Ratings)
      ..retainWhere((foodID) => user2Ratings.contains(foodID));

    if (commonRatings.isEmpty) {
      return 0.0; // No common ratings, no similarity
    }

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

  List<int> getSimilarUsers(int targetUser) {
    Map<int, double> userSimilarities = {};

    for (var rating in ratings) {
      if (rating.userID != targetUser) {
        double similarity = calculateSimilarity(targetUser, rating.userID);
        userSimilarities[rating.userID] = similarity;
      }
    }

    userSimilarities.removeWhere((key, value) => value.isNaN);

    return userSimilarities.keys.toList()
      ..sort((a, b) => userSimilarities[b]!.compareTo(userSimilarities[a]!));
  }

  List<int> recommendFoods(int targetUser) {
    List<int> targetUserRatings = getRatedFoods(targetUser);
    List<int> recommendedFoods = [];

    List<int> similarUsers = getSimilarUsers(targetUser);

    for (var user in similarUsers) {
      List<int> userRatings = getRatedFoods(user);
      List<int> unratedFoods =
          userRatings.where((foodID) => !targetUserRatings.contains(foodID)).toList();
      recommendedFoods.addAll(unratedFoods);

      if (recommendedFoods.length >= 5) {
        break;
      }
    }

    return recommendedFoods.toSet().toList();
  }
}

// Example usage
Future<void> getRecommendations() async {
  FoodRatings _foodRatings = FoodRatings();
  
  // Retrieve ratings from database
  List<Rating> ratings = await _foodRatings.getRatingsForRecommendation();

  RecommendationSystem recommendationSystem = RecommendationSystem(ratings: ratings);

  int targetUser = 4;
  List<int> recommendedFoods = recommendationSystem.recommendFoods(targetUser);

  print('Recommended Foods for User $targetUser: $recommendedFoods');
}
