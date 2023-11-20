import 'dart:math';
import 'package:jom_makan/model/rating.dart';

class RecommendationSystem {
  final List<Rating> ratings;

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

void main() {
  // Sample ratings
  List<Rating> ratings = [
    Rating(ratingID: 1, foodID: 2, userID: 2, stars: 4),
    Rating(ratingID: 2, foodID: 3, userID: 5, stars: 4),
    Rating(ratingID: 3, foodID: 5, userID: 4, stars: 5),
    Rating(ratingID: 4, foodID: 3, userID: 5, stars: 1),
    Rating(ratingID: 5, foodID: 5, userID: 4, stars: 5),
    Rating(ratingID: 6, foodID: 4, userID: 6, stars: 5),
    Rating(ratingID: 7, foodID: 2, userID: 7, stars: 4),
    Rating(ratingID: 8, foodID: 4, userID: 7, stars: 5),
    Rating(ratingID: 9, foodID: 1, userID: 6, stars: 3),
    Rating(ratingID: 10, foodID: 5, userID: 4, stars: 4),
  ];

  RecommendationSystem recommendationSystem = RecommendationSystem(ratings: ratings);

  int targetUser = 2;
  List<int> recommendedFoods = recommendationSystem.recommendFoods(targetUser);

  print('Recommended Foods for User $targetUser: $recommendedFoods');
}
