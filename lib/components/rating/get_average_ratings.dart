import 'package:jom_makan/server/rating/get_ratings.dart';

class GetAverageRatings {
  final FoodRatings _foodRatings = FoodRatings();

  // Method to get average ratings and update the state
  Future<double> setAverageRating(int foodID) async {
    try {
      List<int> ratings = await _foodRatings.getRatingsForFood(foodID);

      double newAverageRating = _foodRatings.calculateAverageRating(ratings);

      return newAverageRating;
    } catch (error) {
      // Handle errors if needed
      print('Error while getting average ratings: $error');
      return 0.0;
    }
  }

  // Method to get number of ratings in one food
  Future<int> setNoRatings(int foodID) async {
    try {
      return await _foodRatings.getNumberOfRatings(foodID);
    } catch (error) {
      print('Error while getting number of ratings: $error');
      return 0;
    }
  }
}